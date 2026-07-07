import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CartItemEntity } from '../../database/entities/cart-item.entity';
import { AddToCartDto } from './dto/add-to-cart.dto';

@Injectable()
export class CartService {
  constructor(
    @InjectRepository(CartItemEntity)
    private cartItemRepository: Repository<CartItemEntity>,
  ) {}

  async addItem(userId: string, addToCartDto: AddToCartDto): Promise<CartItemEntity> {
    const { productId, quantity, price } = addToCartDto;

    let cartItem = await this.cartItemRepository.findOne({
      where: { userId, productId },
    });

    if (cartItem) {
      cartItem.quantity += quantity;
    } else {
      cartItem = this.cartItemRepository.create({
        userId,
        productId,
        quantity,
        price,
      });
    }

    return this.cartItemRepository.save(cartItem);
  }

  async getCart(userId: string) {
    const items = await this.cartItemRepository.find({
      where: { userId },
      relations: ['product'],
    });

    const total = items.reduce((sum, item) => sum + Number(item.price) * item.quantity, 0);

    return {
      items,
      total,
      itemCount: items.length,
    };
  }

  async updateItem(userId: string, productId: string, quantity: number) {
    const cartItem = await this.cartItemRepository.findOne({
      where: { userId, productId },
    });

    if (!cartItem) {
      throw new NotFoundException('Cart item not found');
    }

    cartItem.quantity = quantity;
    return this.cartItemRepository.save(cartItem);
  }

  async removeItem(userId: string, productId: string): Promise<void> {
    await this.cartItemRepository.delete({ userId, productId });
  }

  async clearCart(userId: string): Promise<void> {
    await this.cartItemRepository.delete({ userId });
  }
}
