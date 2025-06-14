import { CanActivate, ExecutionContext } from '@nestjs/common';
import { Request } from 'express';

export class RoleGuard implements CanActivate {
  private allowedRoles: string[];

  constructor(allowedRoles: string[]) {
    this.allowedRoles = allowedRoles;
  }

  canActivate(context: ExecutionContext): boolean {
    const ctx = context.switchToHttp();
    const request: Request = ctx.getRequest<Request>();
    const userRole = request['user']?.['role'];

    if (this.allowedRoles.includes(userRole)) {
      return true;
    }
    return false;
  }
}
