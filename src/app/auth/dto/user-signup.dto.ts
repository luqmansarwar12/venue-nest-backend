import {
  IsArray,
  IsBoolean,
  IsEmail,
  IsEnum,
  IsLowercase,
  IsMobilePhone,
  IsNotEmpty,
  IsNotIn,
  IsNumber,
  IsOptional,
  IsPositive,
  IsString,
  Length,
  Min,
  ValidateIf,
  ValidateNested,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { UserRole } from 'src/shared/enums';
import { Type } from 'class-transformer';

export class UserSignupDto {
  @ApiProperty()
  @IsNotEmpty({ message: 'Email is required' })
  @IsEmail({}, { message: 'Invalid email format' })
  email: string;

  @ApiProperty()
  @IsNotEmpty({ message: 'Password is required' })
  @IsString({ message: 'Password must be a string' })
  @Length(8, 14, { message: 'Password must be between 8 and 14 characters' })
  password: string;

  @ApiProperty()
  @IsNotEmpty({ message: 'Phone numbers are required' })
  phone: string;

  @ApiProperty()
  @IsNotEmpty({ message: 'Name is required' })
  @IsString({ message: 'Name must be a string' })
  @Length(3, 15, { message: 'Name must be between 3 and 15 characters' })
  name: string;
}

export class SignupDto {
  @ApiProperty({ type: String, enum: UserRole })
  @IsEnum(UserRole)
  @IsNotEmpty({ message: 'Role is required' })
  @IsString({ message: 'Role must be a string' })
  @IsNotIn([UserRole.SUPER_ADMIN])
  role: UserRole;

  @ValidateNested()
  @Type(() => UserSignupDto)
  userData: UserSignupDto;
}
