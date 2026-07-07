import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { OrderEntity } from '../../database/entities/order.entity';
import { OrderItemEntity } from '../../database/entities/order-item.entity';
import { CreateOrderDto } from './dto/create-order.dto';
import { PaginationDto } from '../../common/dtos/pagination.dto';

@Injectable()
export class OrdersService {
  constructor(
    @InjectRepository(OrderEntity)
    private orderRepository: Repository<OrderEntity>,
    @InjectRepository(OrderItemEntity)
    private orderItemRepository: Repository<OrderItemEntity>,
  ) {}

  async createOrder(userId: string, createOrderDto: CreateOrderDto): Promise<OrderEntity> {
    const order = this.orderRepository.create({
      userId,
      status: 'pending',
      paymentStatus: 'pending',
      ...createOrderDto,
    });

    const savedOrder = await this.orderRepository.save(order);

    // Create order items
    const orderItems = createOrderDto.items.map((item) =>
      this.orderItemRepository.create({
        orderId: savedOrder.id,
        ...item,
      }),
    );
    await this.orderItemRepository.save(orderItems);

    return savedOrder;
  }

  async findById(id: string): Promise<OrderEntity> {
    return this.orderRepository.findOne({
      where: { id },
      relations: ['items', 'items.product'],
    });
  }

  async findByUserId(userId: string, pagination: PaginationDto) {
    const { page, limit } = pagination;
    const [data, total] = await this.orderRepository.findAndCount({
      where: { userId },
      relations: ['items', 'items.product'],
      skip: (page - 1) * limit,
      take: limit,
      order: { createdAt: 'DESC' },
    });

    return {
      data,
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit),
      },
    };
  }

  async updateStatus(id: string, status: string): Promise<OrderEntity> {
    await this.orderRepository.update(id, { status });
    return this.findById(id);
  }

  async updatePaymentStatus(id: string, paymentStatus: string, paymentReference?: string) {
    const updateData: any = { paymentStatus };
    if (paymentReference) {
      updateData.paymentReference = paymentReference;
    }
    await this.orderRepository.update(id, updateData);
    return this.findById(id);
  }
}
