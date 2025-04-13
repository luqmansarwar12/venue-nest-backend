import { HttpException, HttpStatus, Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {

    if(true){
      throw new HttpException('Exception message',  HttpStatus.NOT_FOUND)
    }
    return 'Hello World!';
  }
}
