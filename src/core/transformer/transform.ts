import {
    ClassConstructor,
    ClassTransformOptions,
  } from 'class-transformer/types/interfaces';
  
  import { instanceToPlain, plainToInstance } from 'class-transformer';
  
  export class Transform {
    private static readonly options: ClassTransformOptions = {
      enableImplicitConversion: true,
      excludeExtraneousValues: true,
    };
  
    static toInstance<T>(
      obj: T,
      type: ClassConstructor<any>,
      options?: ClassTransformOptions,
    ): T {
      return plainToInstance(type, obj, options || this.options);
    }
  
    static toPlain<T>(data: T, options?: ClassTransformOptions) {
      return instanceToPlain(data, options);
    }
  }