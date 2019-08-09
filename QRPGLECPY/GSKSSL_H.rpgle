**FREE
//- Copyright (c) 2019 Christian Brunner
//-
//- Permission is hereby granted, free of charge, to any person obtaining a copy
//- of this software and associated documentation files (the "Software"), to deal
//- in the Software without restriction, including without limitation the rights
//- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//- copies of the Software, and to permit persons to whom the Software is
//- furnished to do so, subject to the following conditions:

//- The above copyright notice and this permission notice shall be included in all
//- copies or substantial portions of the Software.

//- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//- SOFTWARE.

/IF DEFINED (GSKSSL_H)
/EOF
/ENDIF

/DEFINE GSKSSL_H


DCL-PR gsk_Environment_Open INT(10) EXTPROC('gsk_environment_open');
  Environment_Handle LIKE(GSK_Handle);
END-PR;

DCL-PR gsk_Environment_Init INT(10) EXTPROC('gsk_environment_init');
  Environment_Handle LIKE(GSK_Handle) VALUE;
END-PR;

DCL-PR gsk_Environment_Close INT(10) EXTPROC('gsk_environment_close');
  Environment_Handle LIKE(GSK_Handle);
END-PR;

DCL-PR gsk_Attribute_Get_Buffer INT(10) EXTPROC('gsk_attribute_get_buffer');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  BufferID LIKE(GSK_Buffer_ID) VALUE;
  Buffer POINTER VALUE;
  BufferSize INT(10);
END-PR;

DCL-PR gsk_Attribute_Set_Buffer INT(10) EXTPROC('gsk_attribute_set_buffer');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  BufferID LIKE(GSK_Buffer_ID) VALUE;
  Buffer POINTER VALUE OPTIONS(*STRING);
  BufferSize INT(10) VALUE;
END-PR;

DCL-PR gsk_Attribute_Get_Cert_Info INT(10) EXTPROC('gsk_attribute_get_cert_info');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  CertificateID LIKE(GSK_Certificate_ID) VALUE;
  CertificateDataElement POINTER VALUE;
  CertificateDataElementCount INT(10);
END-PR;

DCL-PR gsk_Attribute_Get_ENum INT(10) EXTPROC('gsk_attribute_get_enum');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  ENumID LIKE(GSK_ENum_ID) VALUE;
  ENumValue LIKE(GSK_ENum_Value);
END-PR;

DCL-PR gsk_Attribute_Get_Numeric_Value INT(10) EXTPROC('gsk_attribute_get_numeric_value');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  NumericID LIKE(GSK_Num_ID) VALUE;
  NumericValue INT(10);
END-PR;

DCL-PR gsk_Attribute_Set_ENum INT(10) EXTPROC('gsk_attribute_set_enum');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  ENumID LIKE(GSK_ENum_ID) VALUE;
  ENumValue LIKE(GSK_ENum_Value) VALUE;
END-PR;

DCL-PR gsk_Attribute_Set_Numeric_Value INT(10) EXTPROC('gsk_attribute_set_numeric_value');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  NumericID LIKE(GSK_Num_ID) VALUE;
  NumericValue INT(10) VALUE;
END-PR;

DCL-PR gsk_Secure_Soc_Open INT(10) EXTPROC('gsk_secure_soc_open');
  Environment_Handle LIKE(GSK_Handle) VALUE;
  SSN_Handle LIKE(GSK_Handle);
END-PR;

DCL-PR gsk_Secure_Soc_Init INT(10) EXTPROC('gsk_secure_soc_init');
  SSN_Handle LIKE(GSK_Handle) VALUE;
END-PR;

DCL-PR gsk_Secure_Soc_Misc INT(10) EXTPROC('gsk_secure_soc_misc');
  SSN_Handle LIKE(GSK_Handle) VALUE;
  MiscID LIKE(GSK_Misc_ID) VALUE;
END-PR;

DCL-PR gsk_Secure_Soc_Read INT(10) EXTPROC('gsk_secure_soc_read');
  SSN_Handle LIKE(GSK_Handle) VALUE;
  ReadBuffer POINTER VALUE;
  ReadBufferSize INT(10) VALUE;
  AmtRead INT(10);
END-PR;

DCL-PR gsk_Secure_Soc_Write INT(10) EXTPROC('gsk_secure_soc_write');
  SSN_Handle LIKE(GSK_Handle) VALUE;
  WriteBuffer POINTER VALUE;
  WriteBufferSize INT(10) VALUE;
  AmtWritten INT(10);
END-PR;

DCL-PR gsk_Secure_Soc_Close INT(10) EXTPROC('gsk_secure_soc_close');
  SSN_Handle LIKE(GSK_Handle);
END-PR;

DCL-PR gsk_Secure_Soc_StartRecv INT(10) EXTPROC('gsk_secure_soc_startRecv');
  SSN_Handle LIKE(GSK_Handle) VALUE;
  IOCompletionPort INT(10) VALUE;
  CommunicationArea POINTER VALUE;
END-PR;

DCL-PR gsk_Secure_Soc_StartSend INT(10) EXTPROC('gsk_secure_soc_startSend');
  SSN_Handle LIKE(GSK_Handle) VALUE;
  IOCompletionPort INT(10) VALUE;
  CommunicationArea POINTER VALUE;
END-PR;

DCL-PR gsk_StrError POINTER EXTPROC('gsk_strerror');
  GSK_Return_Value INT(10) VALUE;
END-PR;


DCL-S GSK_Handle POINTER;

DCL-C GSK_OK 0;
DCL-C GSK_INVALID_HANDLE 1;
DCL-C GSK_API_NOT_AVAILABLE 2;
DCL-C GSK_INTERNAL_ERROR 3;
DCL-C GSK_INSUFFICIENT_STORAGE 4;
DCL-C GSK_INVALID_STATE 5;
DCL-C GSK_KEY_LABEL_NOT_FOUND 6;
DCL-C GSK_CERTIFICATE_NOT_AVAILABLE 7;
DCL-C GSK_ERROR_CERT_VALIDATION 8;
DCL-C GSK_ERROR_CRYPTO 9;
DCL-C GSK_ERROR_ASN 10;
DCL-C GSK_ERROR_LDAP 11;
DCL-C GSK_ERROR_UNKNOWN_ERROR 12;

DCL-C GSK_OPEN_CIPHER_ERROR 101;
DCL-C GSK_KEYFILE_IO_ERROR 102;
DCL-C GSK_KEYFILE_INVALID_FORMAT 103;
DCL-C GSK_KEYFILE_DUPLICATE_KEY 104;
DCL-C GSK_KEYFILE_DUPLICATE_LABEL 105;
DCL-C GSK_BAD_FORMAT_OR_INVALID_PASSWORD 106;
DCL-C GSK_KEYFILE_CERT_EXPIRED 107;
DCL-C GSK_ERROR_LOAD_GSKLIB 108;

DCL-C GSK_NO_KEYFILE_PASSWORD 201;
DCL-C GSK_KEYRING_OPEN_ERROR 202;
DCL-C GSK_RSA_TEMP_KEY_PAIR 203;

DCL-C GSK_CLOSE_FAILED 203;

DCL-C GSK_ERROR_BAD_DATE 401;
DCL-C GSK_ERROR_NO_CIPHERS 402;
DCL-C GSK_ERROR_NO_CERTIFICATE 403;
DCL-C GSK_ERROR_BAD_CERTIFICATE 404;
DCL-C GSK_ERROR_UNSUPPORTED_CERTIFICATE_TYPE 405;
DCL-C GSK_ERROR_IO 406;
DCL-C GSK_ERROR_BAD_KEYFILE_LABEL 407;
DCL-C GSK_ERROR_BAD_KEYFILE_PASSWORD 408;
DCL-C GSK_ERROR_BAD_KEY_LEN_FOR_EXPORT 409;
DCL-C GSK_ERROR_BAD_MESSAGE 410;
DCL-C GSK_ERROR_BAD_MAC 411;
DCL-C GSK_ERROR_UNSUPPORTED 412;
DCL-C GSK_ERROR_BAD_CERT_SIG 413;
DCL-C GSK_ERROR_BAD_CERT 414;
DCL-C GSK_ERROR_BAD_PEER 415;
DCL-C GSK_ERROR_PERMISSION_DENIED 416;
DCL-C GSK_ERROR_SELF_SIGNED 417;
DCL-C GSK_ERROR_NO_READ_FUNCTION 418;
DCL-C GSK_ERROR_NO_WRITE_FUNCTION 419;
DCL-C GSK_ERROR_SOCKET_CLOSED 420;
DCL-C GSK_ERROR_BAD_V2_CIPHER 421;
DCL-C GSK_ERROR_BAD_V3_CIPHER 422;
DCL-C GSK_ERROR_BAD_SEC_TYPE 423;
DCL-C GSK_ERROR_BAD_SEC_TYPE_COMBINATION 424;
DCL-C GSK_ERROR_HANDLE_CREATION_FAILED 425;
DCL-C GSK_ERROR_INITIALIZATION_FAILED 426;
DCL-C GSK_ERROR_LDAP_NOT_AVAILABLE 427;
DCL-C GSK_ERROR_NO_PRIVATE_KEY 428;

DCL-C GSK_INVALID_BUFFER_SIZE 501;
DCL-C GSK_WOULD_BLOCK 502;

DCL-C GSK_MISC_INVALID_ID 602;

DCL-C GSK_ATTRIBUTE_INVALID_ID 701;
DCL-C GSK_ATTRIBUTE_INVALID_LENGTH 702;
DCL-C GSK_ATTRIBUTE_INVALID_ENUMERATION 703;
DCL-C GSK_ATTRIBUTE_INVALID_SID_CACHE 704;
DCL-C GSK_ATTRIBUTE_INVALID_NUMERIC_VALUE 705;

DCL-C GSK_SC_OK 1501;
DCL-C GSK_SC_CANCEL 1502;

DCL-C GSK_IBMI_BASE 6000;
DCL-C GSK_IBMI_BASE_END 6999;
DCL-C GSK_ZOS_BASE 7000;
DCL-C GSK_ZOS_BASE_END 7999;

DCL-C GSK_IBMI_ERROR_NOT_TRUSTED_ROOT 6000;
DCL-C GSK_IBMI_ERROR_PASSWORD_EXPIRED 6001;
DCL-C GSK_IBMI_ERROR_NOT_REGISTERED 6002;
DCL-C GSK_IBMI_ERROR_NO_ACCESS 6003;
DCL-C GSK_IBMI_ERROR_CLOSED 6004;
DCL-C GSK_IBMI_ERROR_NO_CERTIFICATE_AUTHORITIES 6005;
DCL-C GSK_IBMI_ERROR_NO_INITIALIZE 6007;
DCL-C GSK_IBMI_ERROR_ALREADY_SECURE 6008;
DCL-C GSK_IBMI_ERROR_NOT_TCP 6009;
DCL-C GSK_IBMI_ERROR_INVALID_POINTER 6010;
DCL-C GSK_IBMI_ERROR_TIMED_OUT 6011;
DCL-C GSK_IBMI_ASYNCHRONOUS_RECV 6012;
DCL-C GSK_IBMI_ASYNCHRONOUS_SEND 6013;
DCL-C GSK_IBMI_ERROR_INVALID_OVERLAPPEDIO_T 6014;
DCL-C GSK_IBMI_ERROR_INVALID_IOCOMPLETIONPORT 6015;
DCL-C GSK_IBMI_ERROR_BAD_SOCKET_DESCRIPTOR 6016;
DCL-C GSK_IBMI_4BYTE_VALUE 70000;

DCL-S GSK_Misc_ID INT(10);
DCL-C GSK_RESET_CIPHER 100;
DCL-C GSK_RESET_SESSION 101;

DCL-S GSK_Buffer_ID INT(10);
DCL-C GSK_USER_DATA 200;
DCL-C GSK_KEYRING_FILE 201;
DCL-C GSK_KEYRING_PW 202;
DCL-C GSK_KEYRING_LABEL 203;
DCL-C GSK_KEYRING_STASH_FILE 204;
DCL-C GSK_V2_CIPHER_SPECS 205;
DCL-C GSK_V3_CIPHER_SPECS 206;
DCL-C GSK_CONNECT_CIPHER_SPEC 207;
DCL-C GSK_CONNECT_SEC_TYPE 208;
DCL-C GSK_LDAP_SERVER 209;
DCL-C GSK_LDAP_USER 210;
DCL-C GSK_LDAP_USER_PW 211;
DCL-C GSK_SID_VALUE 212;
DCL-C GSK_PKCS11_DRIVER_PATH 213;
DCL-C GSK_OS400_APPLICATION_ID 6999;

DCL-S GSK_Num_ID INT(10);
DCL-C GSK_FD 300;
DCL-C GSK_V2_SESSION_TIMEOUT 301;
DCL-C GSK_V3_SESSION_TIMEOUT 302;
DCL-C GSK_LDAP_SERVER_PORT 303;
DCL-C GSK_V2_SIDCACHE_SIZE 304;
DCL-C GSK_V3_SIDCACHE_SIZE 305;
DCL-C GSK_CERTIFICATE_VALIDATION_CODE 6996;
DCL-C GSK_HANDSHAKE_TIMEOUT 6998;

DCL-S GSK_ENum_ID INT(10);
DCL-C GSK_CLIENT_AUTH_TYPE 401;
DCL-C GSK_SESSION_TYPE 402;
DCL-C GSK_PROTOCOL_SSLV2 403;
DCL-C GSK_PROTOCOL_SSLV3 404;
DCL-C GSK_PROTOCOL_USED 405;
DCL-C GSK_SID_FIRST 406;
DCL-C GSK_PROTOCOL_TLSV1 407;
DCL-C GSK_PROTOCOL_TLSV1_1 437;
DCL-C GSK_PROTOCOL_TLSV1_2 438;
DCL-C GSK_SERVER_AUTH_TYPE 410;

DCL-S GSK_ENum_Value INT(10);
DCL-C GSK_NULL 500;
DCL-C GSK_CLIENT_AUTH_FULL 503;
DCL-C GSK_CLIENT_AUTH_PASSTHRU 505;
DCL-C GSK_CLIENT_SESSION 507;
DCL-C GSK_SERVER_SESSION 508;
DCL-C GSK_SERVER_SESSION_WITH_CL_AUTH 509;
DCL-C GSK_PROTOCOL_SSLV2_ON 510;
DCL-C GSK_PROTOCOL_SSLV2_OFF 511;
DCL-C GSK_PROTOCOL_SSLV3_ON 512;
DCL-C GSK_PROTOCOL_SSLV3_OFF 513;
DCL-C GSK_PROTOCOL_USED_SSLV2 514;
DCL-C GSK_PROTOCOL_USED_SSLV3 515;
DCL-C GSK_SID_IS_FIRST 516;
DCL-C GSK_SID_NOT_FIRST 517;
DCL-C GSK_PROTOCOL_TLSV1_ON 518;
DCL-C GSK_PROTOCOL_TLSV1_OFF 519;
DCL-C GSK_PROTOCOL_USED_TLSV1 520;
DCL-C GSK_SERVER_AUTH_PASSTHRU 535;
DCL-C GSK_OS400_CLIENT_AUTH_REQUIRED 6995;

DCL-S GSK_Cert_Data_ID INT(10);
DCL-C CERT_BODY_DER 600;
DCL-C CERT_BODY_BASE64 601;
DCL-C CERT_SERIAL_NUMBER 602;
DCL-C CERT_COMMON_NAME 610;
DCL-C CERT_LOCALITY 611;
DCL-C CERT_STATE_OR_PROVINCE 612;
DCL-C CERT_COUNTRY 613;
DCL-C CERT_ORG 614;
DCL-C CERT_ORG_UNIT 615;
DCL-C CERT_DN_PRINTABLE 616;
DCL-C CERT_DN_DER 617;
DCL-C CERT_POSTAL_CODE 618;
DCL-C CERT_EMAIL 619;
DCL-C CERT_ISSUER_COMMON_NAME 650;
DCL-C CERT_ISSUER_LOCALITY 651;
DCL-C CERT_ISSUER_STATE_OR_PROVINCE 652;
DCL-C CERT_ISSUER_COUNTRY 653;
DCL-C CERT_ISSUER_ORG 654;
DCL-C CERT_ISSUER_ORG_UNIT 655;
DCL-C CERT_ISSUER_DN_PRINTABLE 656;
DCL-C CERT_ISSUER_DN_DER 657;
DCL-C CERT_ISSUER_POSTAL_CODE 658;
DCL-C CERT_ISSUER_EMAIL 659;

DCL-S p_GSK_Cert_Data_Elem POINTER;
DCL-DS GSK_Cert_Data_Elem QUALIFIED BASED(p_GSK_Cert_Data_Elem);
  Cert_Data_ID LIKE(GSK_Cert_Data_ID);
  Cert_Data_Pointer POINTER;
  Cert_Data_Length INT(10);
END-DS;

DCL-S GSK_Certificate_ID INT(10);
DCL-C GSK_PARTNER_CERT_INFO 700;
DCL-C GSK_LOCAL_CERT_INFO 701;