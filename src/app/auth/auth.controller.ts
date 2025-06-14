import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UseTransformer } from 'src/core/transformer';
import { SignupDto } from './dto/user-signup.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  @Post('')
  @UseTransformer({
    type: SignupDto,
    status: 200,
    apiResponse: true,
  })
  async signup(@Body() dto: SignupDto) {
    return this.authService.signup(dto);
  }
}
