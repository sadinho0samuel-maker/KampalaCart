import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ProductEntity } from '../../database/entities/product.entity';
import { CreateProductDto } from './dto/create-product.dto';
import { PaginationDto } from '../../common/dtos/pagination.dto';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(ProductEntity)
    private productRepository: Repository<ProductEntity>,
  ) {}

  async create(createProductDto: CreateProductDto): Promise<ProductEntity> {
    const product = this.productRepository.create(createProductDto);
    return this.productRepository.save(product);
  }

  async findAll(pagination: PaginationDto) {
    const { page, limit } = pagination;
    const [data, total] = await this.productRepository.findAndCount({
      skip: (page - 1) * limit,
      take: limit,
      where: { isActive: true },
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

  async findById(id: string): Promise<ProductEntity> {
    return this.productRepository.findOne({ where: { id, isActive: true } });
  }

  async findByCategory(category: string, pagination: PaginationDto) {
    const { page, limit } = pagination;
    const [data, total] = await this.productRepository.findAndCount({
      where: { category, isActive: true },
      skip: (page - 1) * limit,
      take: limit,
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

  async search(query: string, pagination: PaginationDto) {
    const { page, limit } = pagination;
    const [data, total] = await this.productRepository
      .createQueryBuilder('product')
      .where('product.isActive = :isActive', { isActive: true })
      .andWhere('(product.name ILIKE :query OR product.description ILIKE :query)', {
        query: `%${query}%`,
      })
      .skip((page - 1) * limit)
      .take(limit)
      .getManyAndCount();

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

  async update(id: string, updateData: Partial<ProductEntity>): Promise<ProductEntity> {
    await this.productRepository.update(id, updateData);
    return this.findById(id);
  }

  async delete(id: string): Promise<void> {
    await this.productRepository.update(id, { isActive: false });
  }
}
