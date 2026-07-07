import { Controller, Get, Post, Body, Param, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { ProductsService } from './products.service';
import { CreateProductDto } from './dto/create-product.dto';
import { PaginationDto } from '../../common/dtos/pagination.dto';

@ApiTags('products')
@Controller('api/products')
export class ProductsController {
  constructor(private productsService: ProductsService) {}

  @Get()
  @ApiOperation({ summary: 'Get all products' })
  async getAll(@Query() pagination: PaginationDto) {
    return this.productsService.findAll(pagination);
  }

  @Get('search')
  @ApiOperation({ summary: 'Search products' })
  async search(@Query('q') query: string, @Query() pagination: PaginationDto) {
    return this.productsService.search(query, pagination);
  }

  @Get('category/:category')
  @ApiOperation({ summary: 'Get products by category' })
  async getByCategory(@Param('category') category: string, @Query() pagination: PaginationDto) {
    return this.productsService.findByCategory(category, pagination);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get product by ID' })
  async getById(@Param('id') id: string) {
    return this.productsService.findById(id);
  }

  @Post()
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Create product' })
  async create(@Body() createProductDto: CreateProductDto) {
    return this.productsService.create(createProductDto);
  }
}
