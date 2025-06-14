import { ExecutionContext, Injectable } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';
import { BY_PASS_URLS } from '../../shared/constants';

@Injectable()
export class JwtAuthGuard extends AuthGuard('jwt') {
  canActivate(context: ExecutionContext) {
    const ctx = context.switchToHttp();
    const request = ctx.getRequest<Request>();

    for (const url of BY_PASS_URLS) {
      if (request.url === url) return true;
    }
    return super.canActivate(context);
  }
}
