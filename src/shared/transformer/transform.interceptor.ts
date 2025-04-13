import {
    CallHandler,
    ExecutionContext,
    Inject,
    Injectable,
    NestInterceptor,
  } from '@nestjs/common';
  import { Reflector } from '@nestjs/core/services/reflector.service';
  import { Observable } from 'rxjs';
  import { map } from 'rxjs/operators';
  import { TransformerEnum } from '../constants/enums';
  import { Transform } from './transform';
  
  @Injectable()
  export class TransformInterceptor<T> implements NestInterceptor<T> {
    constructor(
      @Inject(Reflector.name) protected readonly reflector: Reflector,
    ) {}
  
    intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
      const TransformerClass = this.reflector.get(
        TransformerEnum.Class,
        context.getHandler(),
      );
      const statusCode = this.reflector.get(
        TransformerEnum.Status,
        context.getHandler(),
      );
      context.switchToHttp().getResponse().status(statusCode);
      return next
        .handle()
        .pipe(map((data) => Transform.toInstance(data, TransformerClass)));
    }
  }

  