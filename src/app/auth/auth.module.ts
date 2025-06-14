import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { PrismaModule } from 'src/database/prisma.module';

@Module({
  imports: [PrismaModule],
  exports: [],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}
