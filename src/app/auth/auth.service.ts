import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/prisma.service';
import { SignupDto } from './dto/user-signup.dto';

@Injectable()
export class AuthService {
  constructor(private readonly prisma: PrismaService) {}

  async signup(dto: SignupDto) {}
}
