// package: tutorial
// file: test/addressbook.proto

import * as jspb from "google-protobuf";
import * as google_protobuf_timestamp_pb from "google-protobuf/google/protobuf/timestamp_pb";

export class Person extends jspb.Message {
  getName(): string;
  setName(value: string): void;

  getId(): number;
  setId(value: number): void;

  getEmail(): string;
  setEmail(value: string): void;

  clearPhonesList(): void;
  getPhonesList(): Array<Person.PhoneNumber>;
  setPhonesList(value: Array<Person.PhoneNumber>): void;
  addPhones(value?: Person.PhoneNumber, index?: number): Person.PhoneNumber;

  hasLastUpdated(): boolean;
  clearLastUpdated(): void;
  getLastUpdated(): google_protobuf_timestamp_pb.Timestamp | undefined;
  setLastUpdated(value?: google_protobuf_timestamp_pb.Timestamp): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): Person.AsObject;
  static toObject(includeInstance: boolean, msg: Person): Person.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: Person, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): Person;
  static deserializeBinaryFromReader(message: Person, reader: jspb.BinaryReader): Person;
}

export namespace Person {
  export type AsObject = {
    name: string,
    id: number,
    email: string,
    phonesList: Array<Person.PhoneNumber.AsObject>,
    lastUpdated?: google_protobuf_timestamp_pb.Timestamp.AsObject,
  }

  export class PhoneNumber extends jspb.Message {
    getNumber(): string;
    setNumber(value: string): void;

    getType(): Person.PhoneTypeMap[keyof Person.PhoneTypeMap];
    setType(value: Person.PhoneTypeMap[keyof Person.PhoneTypeMap]): void;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): PhoneNumber.AsObject;
    static toObject(includeInstance: boolean, msg: PhoneNumber): PhoneNumber.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: PhoneNumber, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): PhoneNumber;
    static deserializeBinaryFromReader(message: PhoneNumber, reader: jspb.BinaryReader): PhoneNumber;
  }

  export namespace PhoneNumber {
    export type AsObject = {
      number: string,
      type: Person.PhoneTypeMap[keyof Person.PhoneTypeMap],
    }
  }

  export interface PhoneTypeMap {
    MOBILE: 0;
    HOME: 1;
    WORK: 2;
  }

  export const PhoneType: PhoneTypeMap;
}

export class AddressBook extends jspb.Message {
  clearPeopleList(): void;
  getPeopleList(): Array<Person>;
  setPeopleList(value: Array<Person>): void;
  addPeople(value?: Person, index?: number): Person;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): AddressBook.AsObject;
  static toObject(includeInstance: boolean, msg: AddressBook): AddressBook.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: AddressBook, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): AddressBook;
  static deserializeBinaryFromReader(message: AddressBook, reader: jspb.BinaryReader): AddressBook;
}

export namespace AddressBook {
  export type AsObject = {
    peopleList: Array<Person.AsObject>,
  }
}

