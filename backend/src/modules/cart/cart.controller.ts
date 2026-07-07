import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, Request } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { CartService } from './cart.service';
import { AddToCartDto } from './dto/add-to-cart.dto';
import { UpdateCartItemDto } from './dto/update-cart-item.dto';

@ApiTags('cart')
@Controller('api/cart')
export class CartController {
  constructor(private cartService: CartService) {}

  @Get()
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Get user cart' })
  async getCart(@Request() req: any) {
    return this.cartService.getCart(req.user.userId);
  }

  @Post('add')
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Add item to cart' })
  async addItem(@Request() req: any, @Body() addToCartDto: AddToCartDto) {
    return this.cartService.addItem(req.user.userId, addToCartDto);
  }

  @Put(':productId')
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Update cart item' })
  async updateItem(
    @Request() req: any,
    @Param('productId') productId: string,
    @Body() updateCartItemDto: UpdateCartItemDto,
  ) {
    return this.cartService.updateItem(req.user.userId, productId, updateCartItemDto.quantity);
  }

  @Delete(':productId')
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Remove item from cart' })
  async removeItem(@Request() req: any, @Param('productId') productId: string) {
    await this.cartService.removeItem(req.user.userId, productId);
    return { message: 'Item removed' };
  }

  @Delete()
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Clear cart' })
  async clearCart(@Request() req: any) {
    await this.cartService.clearCart(req.user.userId);
    return { message: 'Cart cleared' };
  }
}
