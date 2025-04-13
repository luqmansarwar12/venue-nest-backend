import { applyDecorators, SetMetadata, UseInterceptors } from '@nestjs/common';
import { ApiResponseMetadata } from '@nestjs/swagger/dist/decorators/api-response.decorator';
import { ClassConstructor } from 'class-transformer/types/interfaces';
import { ApiResponse } from '@nestjs/swagger';
import { TransformerEnum } from '../constants/enums';
import { TransformInterceptor } from './transform.interceptor';

export function UseTransformer<T>(
  options?: ApiResponseMetadata & {
    type: ClassConstructor<T>;
    apiResponse?: boolean;
  },
) {
    if (!options) {
        throw new Error('Options cannot be undefined');
      }
    if (!('status' in options)) {
        Object.assign(options, { status: 200 });
    }
    const decorators: Array<
        ClassDecorator | MethodDecorator | PropertyDecorator
    > = [
        SetMetadata(TransformerEnum.Class, options.type),
        SetMetadata(TransformerEnum.Status, options.status),
        UseInterceptors(TransformInterceptor),
    ];
    if (options.apiResponse != false) {
        decorators.push(ApiResponse(options));
    }
    return applyDecorators(...decorators);
}