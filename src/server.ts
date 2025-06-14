import './config/env';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import {
  HttpException,
  HttpStatus,
  INestApplication,
  Logger,
  ValidationError,
  ValidationPipe,
} from '@nestjs/common';
import { app } from './config';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ValidatorErrors } from './core/interfaces/errors.interface';
import { NestExpressApplication } from '@nestjs/platform-express';

export class VenueNestApp {
  static app: INestApplication;
  static port = app.APP_PORT || 3000;
  private static readonly logger = new Logger(VenueNestApp.name);

  public static async init(): Promise<void> {
    if (!this.app) {
      await this.initApp();
      this.setupSwagger();
      this.setupValidationPipe();
      await this.listen();
    }
  }

  private static async initApp(): Promise<void> {
    this.app = await NestFactory.create<NestExpressApplication>(AppModule, {
      cors: { origin: '*' },
    });
  }

  private static setupSwagger() {
    const config = new DocumentBuilder()
      .setTitle('VenueNest API')
      .setDescription('VenueNest API Documentation')
      .setVersion('1.0')
      .addBearerAuth(
        {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
          name: 'JWT',
          description: 'Enter JWT TOKEN',
          in: 'header',
        },
        'JWT-Auth',
      )
      .build();
    const swaggerDocument = SwaggerModule.createDocument(this.app, config);
    SwaggerModule.setup('api/explorer', this.app, swaggerDocument);
  }

  private static setupValidationPipe() {
    this.app.useGlobalPipes(
      new ValidationPipe({
        transform: true,
        whitelist: true,
        validationError: { target: true, value: true },

        exceptionFactory: (errors: ValidationError[]) => {
          const errorsException = this.exceptionFactory(errors);
          const firstError = Object.keys(errorsException)[0];
          const firstErrorMessage = errorsException[firstError];
          this.logger.error(`Validation Error: ${firstErrorMessage}`);
          return new HttpException(
            `${firstErrorMessage}`,
            HttpStatus.UNPROCESSABLE_ENTITY,
          );
        },
      }),
    );
  }

  private static exceptionFactory(errors: ValidationError[]): ValidatorErrors {
    const errorsException: ValidatorErrors = {};
    for (const error of errors) {
      if (error.constraints) {
        errorsException[error.property] =
          Object.values(error.constraints).shift() ||
          'Unknown validation error';
      } else if (error.children) {
        errorsException[error.property] = this.exceptionFactory(error.children);
      }
    }
    return errorsException;
  }

  private static async listen() {
    await this.app.listen(this.port, () => {
      this.logger.debug(`🚀 Server running on http://localhost:${this.port}`);
      this.logger.debug(
        `📖 Swagger Docs available at http://localhost:${this.port}/api/explorer`,
      );
    });
  }
}

VenueNestApp.init();
