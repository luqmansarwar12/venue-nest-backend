import { Body, Controller, Post } from '@nestjs/common';
import { UserService } from './user.service';
import { UseTransformer } from 'src/core/transformer';
import { CreateUserDto } from './dto/create-user.dto';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}
  @Post('')
  @UseTransformer({
    type: CreateUserDto,
    status: 200,
    apiResponse: true,
  })
  async createUser(@Body() dto: CreateUserDto) {
    return this.userService.createUser(dto);
  }
}
