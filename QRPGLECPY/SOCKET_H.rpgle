     /*-
      * Copyright (c) 1998,2001 Scott C. Klement
      * All rights reserved.
      *
      * Redistribution and use in source and binary forms, with or without
      * modification, are permitted provided that the following conditions
      * are met:
      * 1. Redistributions of source code must retain the above copyright
      *    notice, this list of conditions and the following disclaimer.
      * 2. Redistributions in binary form must reproduce the above copyright
      *    notice, this list of conditions and the following disclaimer in the
      *    documentation and/or other materials provided with the distribution.
      *
      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO
      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTI
      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRI
      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WA
      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
      * SUCH DAMAGE.
      *
      */
     ***********************************************************************
     ***     Header file for doing sockets communications.
     ***
     ***  To use this, you must /COPY RMTCALL/QRPGLESRC, SOCKET_H into
     ***  the "D" specs of your RPG IV source member....
     ***  (or whatever the appropriate source lib/file, member is)
     ***
     ***   Most of the major socket functions and structures are prototyped
     ***   here.  There may be some that I missed (because I havent needed
     ***   them) if you need them, you'll have to add them yourself :)
     ***                                                   SCK 08/06/1998
     ***********************************************************************

     D/if defined(SOCKET_H)
     D/eof
     D/endif
     D/define SOCKET_H

     ***********************************************************************
     **  C O N S T A N T S
     ***********************************************************************
     D IPVERSION       C                   CONST(4)

     ** Address families.
     D*  Only Internet will be included for now...
     D*  If you intend to use other than IP sockets
     D*  you will have to add them in yourself.
     D*
     D AF_INET         C                   CONST(2)

     ** Socket Types:
     D*                                             stream socket (TCP)
     D SOCK_STREAM     C                   CONST(1)
     D*                                             datagram socket (UDP)
     D SOCK_DGRAM      C                   CONST(2)
     D*                                             raw socket
     D SOCK_RAW        C                   CONST(3)


     ** Protocols...
     D*   These are the commonly used protocols in
     D*   the Internet Address Family.
     D*
     D*                                                Internet Protocol
     D IPPROTO_IP      C                   CONST(0)
     D*                                                Transmission Control
     D*                                                Protocol
     D IPPROTO_TCP     C                   CONST(6)
     D*                                                Unordered Datagram
     D*                                                Protocol
     D IPPROTO_UDP     C                   CONST(17)
     D*                                                Raw Packets
     D IPPROTO_RAW     C                   CONST(255)
     D*                                                Internet Control
     D*                                                Msg Protocol
     D IPPROTO_ICMP    C                   CONST(1)
     D*                                                socket layer
     D SOL_SOCKET      C                   CONST(-1)


     ** IP-Level (IPPROTO_IP) options for setsockopt()/getsockopt()
     **   (Note: None of the multicast options are set here, but
     **     they probably should be)
     D*                                                  ip options
     D IP_OPTIONS      C                   CONST(5)
     D*                                                  type of service
     D IP_TOS          C                   CONST(10)
     D*                                                  time to live
     D IP_TTL          C                   CONST(15)
     D*                                                  recv lcl ifc addr
     D IP_RECVLCLIFADDR...
     D                 C                   CONST(99)


     ** TCP level (IPPROTO_TCP) options for setsockopt()/getsockopt()
     D*                                          max segment size (MSS)
     D TCP_MAXSEG      C                   5
     D*                                          dont delay small packets
     D TCP_NODELAY     C                   10


     ** Socket-Level (SOL_SOCKET) options for setsockopt()/getsockopt()
     D*                                          allow broadcast msgs
     D SO_BROADCAST    C                   5
     D*                                          record debug information
     D SO_DEBUG        C                   10
     D*                                          just use interfaces,
     D*                                          bypass routing
     D SO_DONTROUTE    C                   15
     D*                                          error status
     D SO_ERROR        C                   20
     D*                                          keep connections alive
     D SO_KEEPALIVE    C                   25
     D*                                          linger upon close
     D SO_LINGER       C                   30
     D*                                          out-of-band data inline
     D SO_OOBINLINE    C                   35
     D*                                          receive buffer size
     D SO_RCVBUF       C                   40
     D*                                          receive low water mark
     D SO_RCVLOWAT     C                   45
     D*                                          receive timeout value
     D SO_RCVTIMEO     C                   50
     D*                                          re-use local address
     D SO_REUSEADDR    C                   55
     D*                                          send buffer size
     D SO_SNDBUF       C                   60
     D*                                          send low water mark
     D SO_SNDLOWAT     C                   65
     D*                                          send timeout value
     D SO_SNDTIMEO     C                   70
     D*                                          socket type
     D SO_TYPE         C                   75
     D*                                          send loopback
     D SO_USELOOPBACK  C                   80


     ** Types of Service for IP packets
     **  These are indended to be used in the 'ip' data structure
     **  defined below.
     D*                                                  normal
     D IPTOS_NORMAL    C                   CONST(x'00')
     D*                                                  min cost
     D IPTOS_MIN       C                   CONST(x'02')
     D*                                                  reliability
     D IPTOS_RELIABLE  C                   CONST(x'04')
     D*                                                  throughput
     D IPTOS_THRUPUT   C                   CONST(x'08')
     D*                                                  low-delay
     D IPTOS_LOWDELAY  C                   CONST(x'10')


     ** Precedence for Types of Service
     **  These are indended to be used in the 'ip' data structure
     **  defined below.
     D*                                                 net control
     D IPTOS_NET       C                   CONST(x'E0')
     D*                                                 internet control
     D IPTOS_INET      C                   CONST(x'C0')
     D*                                                 critic ecp
     D IPTOS_CRIT      C                   CONST(x'A0')
     D*                                                 flash override
     D IPTOS_FOVR      C                   CONST(x'80')
     D*                                                 flash
     D IPTOS_FLAS      C                   CONST(x'60')
     D*                                                 immediate
     D IPTOS_IMME      C                   CONST(x'40')
     D*                                                 priority
     D IPTOS_PTY       C                   CONST(x'20')
     D*                                                 routine
     D IPTOS_ROUT      C                   CONST(x'10')


     ** I/O flags (for send, sendto, recv, recvfrom functions)
     D*                                               dont route
     D MSG_DONTROUTE   C                   CONST(1)
     D*                                               out-of-band data
     D MSG_OOB         C                   CONST(4)
     D*                                               keep data in buffer
     D MSG_PEEK        C                   CONST(8)


     ** "Special" IP Address values
     D*                                                any address available
     D INADDR_ANY      C                   CONST(0)
     D*                                                broadcast
     D INADDR_BROADCAST...
     D                 C                   CONST(4294967295)
     D*                                                loopback/localhost
     D INADDR_LOOPBACK...
     D                 C                   CONST(2130706433)
     D*                                                no address exists
     D INADDR_NONE     C                   CONST(4294967295)

     ** ICMP message types
     D*                                                  echo reply
     D ICMP_ECHOR      C                   CONST(x'00')
     D*                                                  unreachable
     D ICMP_UNREA      C                   CONST(x'03')
     D*                                                  source quench
     D ICMP_SRCQ       C                   CONST(x'04')
     D*                                                  redirect
     D ICMP_REDIR      C                   CONST(x'05')
     D*                                                  echo
     D ICMP_ECHO       C                   CONST(x'08')
     D*                                                  time exceeded
     D ICMP_TIMX       C                   CONST(x'0B')
     D*                                                  parameter problem
     D ICMP_PARM       C                   CONST(x'0C')
     D*                                                  timestamp request
     D ICMP_TSTP       C                   CONST(x'0D')
     D*                                                  timestamp req reply
     D ICMP_TSTPR      C                   CONST(x'0E')
     D*                                                  info request
     D ICMP_IREQ       C                   CONST(x'0F')
     D*                                                  info request reply
     D ICMP_IREQR      C                   CONST(x'10')
     D*                                                  addr mask request
     D ICMP_MASK       C                   CONST(x'11')
     D*                                                  addr mask req reply
     D ICMP_MASKR      C                   CONST(x'12')

     ** ICMP subtype codes
     D*                                                  network unreachable
     D UNR_NET         C                   CONST(x'00')
     D*                                                  host unreachable
     D UNR_HOST        C                   CONST(x'01')
     D*                                                  protocol unreachble
     D UNR_PROTO       C                   CONST(x'02')
     D*                                                  port unreachable
     D UNR_PORT        C                   CONST(x'03')
     D*                                                  fragmentation needed
     D*                                                  and dont fragment
     D*                                                  flag is set
     D UNR_FRAG        C                   CONST(x'04')
     D*                                                  source route failed
     D UNR_SRCF        C                   CONST(x'05')
     D*                                                  time exceeded in
     D*                                                  transit
     D TIMX_INTRA      C                   CONST(x'00')
     D*                                                  time exceeded in
     D*                                                  frag reassembly
     D TIMX_REASS      C                   CONST(x'01')
     D*                                                  redir for network
     D REDIR_NET       C                   CONST(x'00')
     D*                                                  redir for host
     D REDIR_HOST      C                   CONST(x'01')
     D*                                                  redir for TOS & Net
     D REDIR_TOSN      C                   CONST(x'02')
     D*                                                  redir for TOS & Host
     D REDIR_TOSH      C                   CONST(x'03')

     D/if not defined(FCNTL_CONSTANTS)
     ** fcntl() commands
     D F_DUPFD         C                   CONST(0)
     D F_GETFL         C                   CONST(6)
     D F_SETFL         C                   CONST(7)
     D F_GETOWN        C                   CONST(8)
     D F_SETOWN        C                   CONST(9)

     ** fcntl() flags
     D O_NONBLOCK      C                   CONST(128)
     D O_NDELAY        C                   CONST(128)
     D FNDELAY         C                   CONST(128)
     D FASYNC          C                   CONST(512)
     D/define FCNTL_CONSTANTS
     D/endif

     ***********************************************************************
     **  D A T A    S T R U C T U R E S
     **
     **  Note that data structures here are all set up to be based on
     **  a pointer.  The reason for this is:
     **      1) Data structs that you don't use in your program won't
     **          have memory allocated to them.
     **      2) You can have different "instances" of each data struct
     **          simply by moving the pointer to a different area of
     **          memory.
     ***********************************************************************
     ** Socket Address (Generic, for any network type)
     **
     **   struct sockaddr {
     **       u_short sa_family;
     **       char    sa_data[14];
     **   };
     **
     D p_sockaddr      S               *
     D  SockAddr       DS                  based(p_sockaddr)
     D    SA_Family                   5U 0
     D    SA_Data                    14A


     **  Socket Address (Internet)
     **
     **   struct sockaddr_in {
     **      short           sin_family;
     **      u_short         sin_port;
     **      struct in_addr  sin_addr;
     **      char            sin_zero[8];
     **   };
     **
     D sockaddr_in     DS                  based(p_sockaddr)
     D   sin_Family                   5I 0
     D   sin_Port                     5U 0
     D   sin_addr                    10U 0
     D   sin_zero                     8A


     **
     ** Host Database Entry (for DNS lookups, etc)
     **
     **   (this is a partial implementation... didn't try to
     **    figure out how to deal with all possible addresses
     **    or all possible aliases for a host in RPG)
     **
     **            struct hostent {
     **              char   *h_name;
     **              char   **h_aliases;
     **              int    h_addrtype;
     **              int    h_length;
     **              char   **h_addr_list;
     **            };
     **
     **           #define h_addr   h_addr_list[0]
     **
     D p_hostent       S               *
     D hostent         DS                  Based(p_hostent)
     D   h_name                        *
     D   h_aliases                     *
     D   h_addrtype                   5I 0
     D   h_length                     5I 0
     D   h_addrlist                    *
     D p_h_addr        S               *   Based(h_addrlist)
     D h_addr          S             10U 0 Based(p_h_addr)


     **
     ** Service Database Entry (which service = which port, etc)
     **
     **            struct servent {
     **              char   *s_name;
     **              char   **s_aliases;
     **              int    s_port;
     **              char   *s_proto;
     **            };
     **
     D p_servent       S               *
     D servent         DS                  Based(p_servent)
     D   s_name                        *
     D   s_aliases                     *
     D   s_port                      10I 0
     D   s_proto                       *


     **
     ** IP structure without any opts (for RAW sockets)
     **
     **   struct ip {
     **       unsigned       ip_v:4;       Version (first 4 bits)
     **       unsigned       ip_hl:4;      Header length (next 4)
     **       u_char         ip_tos;       Type of service
     **       short          ip_len;       Total Length
     **       u_short        ip_id;        Identification
     **       short          ip_off;       Fragment offset field
     **       u_char         ip_ttl;       Time to live
     **       u_char         ip_p;         Protocol
     **       u_short        ip_sum;       Checksum
     **       struct in_addr ip_src;       Source Address
     **       struct in_addr ip_dst;       Destination Address
     **   };
     **
     **  Note:  Since you can't define a variable to be 4 bits long
     **     in RPG, ip_v_hl is a combination of ip_v and ip_hl.
     **     with mult/div/mvr and data structures, it should still
     **     be usable...
     **
     **  Since ip_tos & ip_ttl conflict with the definitions for
     **  setsockopt() & getsockopt(), we add an extra S to the end...
     d p_ip            S               *
     D ip              DS                  based(p_ip)
     D   ip_v_hl                      1A
     D   ip_tosS                      1A
     D   ip_len                       5I 0
     D   ip_id                        5U 0
     D   ip_off                       5I 0
     D   ip_ttlS                      1A
     D   ip_p                         1A
     D   ip_sum                       5U 0
     D   ip_src                      10U 0
     D   ip_dst                      10U 0


     **
     ** UDP Packet Header (for RAW sockets)
     **
     **   struct udphdr {                       /* UDP header             */
     **       u_short     uh_sport;             /* source port            */
     **       u_short     uh_dport;             /* destination port       */
     **       short       uh_ulen;              /* UDP length             */
     **       u_short     uh_sum;               /* UDP checksum           */
     **   };
     **
     d p_udphdr        S               *
     d udphdr          DS                  based(p_udphdr)
     D  uh_sport                      5U 0
     D  uh_dport                      5U 0
     D  uh_ulen                       5I 0
     D  uh_sum                        5U 0


     ** Internet Control Message Protocol (ICMP) header
     **   (I THINK I did the unions correctly...  but you might want to
     **    check that out if you're having problems...)
     **
     **   struct icmp {                     /* ICMP header                */
     **       u_char      icmp_type;        /* ICMP message type          */
     **       u_char      icmp_code;        /* type sub code              */
     **       u_short     icmp_cksum;       /* ICMP checksum              */
     **       union {                       /* Message type substructures:*/
     **           u_char ih_pptr;           /*   Parameter problem pointer*/
     **           struct in_addr ih_gwaddr; /*   Redirect gateway address */
     **           struct ih_idseq {         /*   Echo/Timestmp Req/Reply  */
     **               u_short     icd_id;   /*      Indentifier           */
     **               u_short     icd_seq;  /*      Sequence number       */
     **           } ih_idseq;
     **           int ih_void;              /* Unused part of some msgs   */
     **       } icmp_hun;
     **       union {
     **           struct id_ts {            /* Timestamp substructure     */
     **               u_long its_otime;     /*    Originate timestamp     */
     **               u_long its_rtime;     /*    Receive timestamp       */
     **               u_long its_ttime;     /*    Transmit timestamp      */
     **           } id_ts;
     **           struct id_ip  {           /* Imbedded 'original' IP hdr */
     **               struct ip idi_ip;     /* in ICMP error-type msgs.   */
     **                                     /* Includes IP header,IP opts,*/
     **                                     /* and 64 bits of data.       */
     **           } id_ip;
     **           u_long  id_mask;          /* Address mask request/reply */
     **           char    id_data[1];       /* Beginning of echo req data */
     **       } icmp_dun;
     **   };
     D p_icmp          S               *
     D icmp            DS                  based(p_icmp)
     D  icmp_type                     1A
     D  icmp_code                     1A
     D  icmp_cksum                    5U 0
     D  icmp_hun                      4A
     D    ih_gwaddr                  10U 0 OVERLAY(icmp_hun:1)
     D    ih_pptr                     1A   OVERLAY(icmp_hun:1)
     D    ih_idseq                    4A   OVERLAY(icmp_hun:1)
     D      icd_id                    5U 0 OVERLAY(ih_idseq:1)
     D      icd_seq                   5U 0 OVERLAY(ih_idseq:3)
     D    ih_void                     5I 0 OVERLAY(icmp_hun:1)
     D  icmp_dun                     20A
     D    id_ts                      12A   OVERLAY(icmp_dun:1)
     D      its_otime                10U 0 OVERLAY(id_ts:1)
     D      its_rtime                10U 0 OVERLAY(id_ts:5)
     D      its_ttime                10U 0 OVERLAY(id_ts:9)
     D    id_ip                      20A   OVERLAY(icmp_dun:1)
     D      idi_ip                   20A   OVERLAY(id_ip:1)
     D    id_mask                    10U 0 OVERLAY(icmp_dun:1)
     D    id_data                     1A   OVERLAY(icmp_dun:1)


     **
     ** Time Value Structure (for the select() function, etc)
     **
     **      struct timeval {
     **         long  tv_sec;                  /* seconds       */
     **         long  tv_usec;                 /* microseconds  */
     **      };
     **
     **   contrains a structure for specifying a wait time on
     **   a select() function...
     **
     **    tv_sec = seconds.    tv_usec = microseconds
     **
     D p_timeval       S               *
     D timeval         DS                  based(p_timeval)
     D   tv_sec                      10I 0
     D   tv_usec                     10I 0


     **  linger structure   (used with setsockopt or getsockopt)
     **
     **     struct linger {
     **          int   l_onoff;       /* Option Setting ON/OFF */
     **          int   l_linger;      /* Time to linger in seconds */
     **     };
     **
     D p_linger        S               *
     D linger          DS                  BASED(p_linger)
     D   l_onoff                     10I 0
     D   l_linger                    10I 0


     ***********************************************************************
     **  S U B P R O C E D U R E   P R O T O T Y P E S
     ***********************************************************************
     ** --------------------------------------------------------------------
     **
     **    socket--Create Socket
     **
     **    int  socket(int address_family,
     **                int type,
     **                int protocol)
     **
     **
     **     The socket() function is used to create an end point for
     **        communications.  The end point is represented by the
     **        socket descriptor returned by the socket() function.
     **
     ** --------------------------------------------------------------------
     D socket          PR            10I 0 ExtProc('socket')
     D   AddrFamily                  10I 0 Value
     D   SocketType                  10I 0 Value
     D   Protocol                    10I 0 Value


     ** --------------------------------------------------------------------
     **
     **    setsockopt()--Set Socket Options
     **
     **    int  setsockopt(int socket_descriptor,
     **                    int level,
     **                    int option_name,
     **                    char *option_value
     **                    int option_length)
     **
     **    The setsockopt() function is used to set socket options
     **     (there are many, see the book.)
     ** --------------------------------------------------------------------
     D setsockopt      PR            10I 0 ExtProc('setsockopt')
     D   SocketDesc                  10I 0 Value
     D   Opt_Level                   10I 0 Value
     D   Opt_Name                    10I 0 Value
     D   Opt_Value                     *   Value
     D   Opt_Len                     10I 0 Value


     ** --------------------------------------------------------------------
     **
     **    qso_setsockopt98()--Set Socket Options Unix98 style
     **
     **    int  qso_setsockopt98(int socket_descriptor,
     **                          int level,
     **                          int option_name,
     **                          char *option_value
     **                          int option_length)
     ** --------------------------------------------------------------------
     D setSockOpt98    PR            10I 0 ExtProc('qso_setsockopt98')
     D   SocketDesc                  10I 0 Value
     D   Opt_Level                   10I 0 Value
     D   Opt_Name                    10I 0 Value
     D   Opt_Value                     *   Value
     D   Opt_Len                     10I 0 Value


     ** --------------------------------------------------------------------
     **   getsockopt() -- Retrieve Info about Socket Options
     **
     **   int getsockopt(int socket_descriptor,
     **                  int level,
     **                  int option_name,
     **                  char *option_value,
     **                  int *option_length)
     **
     **   Gets various information about the socket's options.
     **   (there are many, see the book.)
     ** --------------------------------------------------------------------
     D getsockopt      PR            10I 0 extproc('getsockopt')
     D   SocketDesc                  10I 0 VALUE
     D   Opt_Level                   10I 0 VALUE
     D   Opt_Name                    10I 0 VALUE
     D   Opt_Value                     *   VALUE
     D   Opt_Length                  10I 0


     ** --------------------------------------------------------------------
     **
     **    getsockname()--Get Local Address for Socket
     **
     **    int  getsockname(int socket_descriptor,
     **              struct sockaddr *local_address,
     **              int *address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **    The getsockname() function is used to retreive the local address
     **      asociated with a socket.
     ** --------------------------------------------------------------------
     D getsockname     PR            10I 0 ExtProc('getsockname')
     D   SocketDesc                  10I 0 Value
     D   p_sockaddr                    *   Value
     D   AddrLength                    *   Value


     **
     ** --------------------------------------------------------------------
     **
     **    getpeername()--Retrieve Destination Address of Socket
     **
     **    int  getpeername(int socket_descriptor,
     **                     struct sockaddr *local_address,
     **                     int *address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **
     **    The getpeername() function is used to retreive the destination
     **      address to which the socket is connected.
     **
     **    Note:  Socket must be connected first.
     **
     ** --------------------------------------------------------------------
     D getpeername     PR            10I 0 ExtProc('getpeername')
     D   SocketDesc                  10I 0 Value
     D   p_sockaddr                    *   Value
     D   AddrLength                  10I 0


     ** --------------------------------------------------------------------
     **    bind()--Bind socket to specified adapter and/or port
     **
     **    int  bind(int socket_descriptor,
     **              struct sockaddr *local_address,
     **              int address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **
     **    The bind() function is used to associate a local address
     **      and port with a socket.   This allows you to get only
     **      socket requests on a specific network adapter, and to
     **      assign a specific port to your socket.
     **    For example, if you're writing a telnet server, you'd
     **      bind to port 23, because thats the standard port for
     **      telnets to listen on.
     **    If we bind to an address of 0, it will allow requests on
     **      any (TCP/IP enabled) network adapter.
     **
     ** --------------------------------------------------------------------
     D bind            PR            10I 0 ExtProc('bind')
     D   Sock_Desc                   10I 0 Value
     D   p_Address                     *   Value
     D   AddressLen                  10I 0 Value


     ** --------------------------------------------------------------------
     **    listen()--Invite Incoming Connections Requests
     **
     **    int  listen(int socket_descriptor,
     **                 int back_log)
     **
     **
     **    The listen() function is used to indicate a willingness to accept
     **       incoming connection requests.  if a listen() is not done,
     **       incoming requests are refused.
     **
     ** --------------------------------------------------------------------
     D listen          PR            10I 0 ExtProc('listen')
     D   SocketDesc                  10I 0 Value
     D   Back_Log                    10I 0 Value


     ** --------------------------------------------------------------------
     **    accept()--Wait for Connection Request and Make Connection
     **
     **    int  accept(int socket_descriptor,
     **              struct sockaddr *address,
     **              int *address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **   The accept() function is used to wait for connection requests.
     **    accept() takes the first connection request on the queue of
     **    pending connection requests and creates a new socket to service
     **    the connection request.
     **
     ** --------------------------------------------------------------------
     D accept          PR            10I 0 ExtProc('accept')
     D   Sock_Desc                   10I 0 Value
     D   p_Address                     *   Value
     D   p_AddrLen                   10I 0


     ** --------------------------------------------------------------------
     **   connect() -- Connect to a host.
     **
     **      int connect(int socket_descriptor,
     **                  struct sockaddr *destination,
     **                  int address_length)
     **
     **      Used to connect to a host.  (Usually used on the client-side)
     **      In TCP applications, this takes an address & port and connects
     **      to a server program thats listening on that port.   In UDP
     **      this simply specifies the address & port to send to.
     **
     ** --------------------------------------------------------------------
     D connect         PR            10I 0 ExtProc('connect')
     D   Sock_Desc                   10I 0 VALUE
     D   p_SockAddr                    *   VALUE
     D   AddressLen                  10I 0 VALUE


     ** --------------------------------------------------------------------
     **    send()--Send Data
     **
     **    int  send(int socket_descriptor,
     **              char *buffer,
     **              int  buffer_length,
     **              int  flags)
     **
     **    Sends data in buffer via socket connection to another program.
     **
     **    In the case of text, it should be converted to ASCII and then
     **    CR/LF terminated.
     **
     ** --------------------------------------------------------------------
     D Send            PR            10I 0 ExtProc('send')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value


     ** --------------------------------------------------------------------
     **    sendto()--Send Data
     **
     **   int sendto(int socket_descriptor,
     **              char *buffer,
     **              int buffer_length,
     **              int flags,
     **              struct sockaddr *destination_address,
     **              int address_length)
     **
     **    Sends data in buffer via connected/connectionless sockets
     **
     **    This is more useful for connectionless sockets (such as UDP)
     **    because allows you to specify the destination address.
     **
     **    When used with a connection-oriented sockets (such as TCP)
     **    the destination address should be set to *NULL, and the length
     **    should be zero.
     **
     ** --------------------------------------------------------------------
     D SendTo          PR            10I 0 ExtProc('sendto')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
     D   DestAddr                      *   Value
     D   AddrLen                     10I 0 Value


     ** --------------------------------------------------------------------
     **    recv()--Receive Data
     **
     **    int  recv(int socket_descriptor,                 I
     **              char *buffer,                          I
     **              int  buffer_length,                    I
     **              int  flags)
     **
     **
     **   The recv() funcion is used to receive data through a socket.
     **
     ** --------------------------------------------------------------------
     D Recv            PR            10I 0 ExtProc('recv')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value


     ** --------------------------------------------------------------------
     **    recvfrom()--Receive Data w/From Address
     **
     **    int  recvfrom(int socket_descriptor,
     **                 char *buffer,
     **                 int buffer_length,
     **                 int flags,
     **                 struct sockaddr *from_address,
     **                 int *address_length)
     **
     **
     **   The recvfrom() function receives data through a connected, or
     **   an unconnected socket.
     **
     **   This is particularly useful for UDP/Connectionless sockets
     **   because it allows you to ascertain who sent the data to you.
     **
     **   The from_address and address_length parms are ignored on
     **   connection-oriented sockets -- or if they are set to *NULL.
     ** --------------------------------------------------------------------
     D RecvFrom        PR            10I 0 ExtProc('recvfrom')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
     D   FromAddr                      *   Value
     D   AddrLength                  10I 0


     ** --------------------------------------------------------------------
     **    close()--End Socket Connection
     **
     **    int  close(int descriptor)
     **
     **    Ends a socket connection, and deletes the socket descriptor.
     **
     **  Note: Due to conflicts with IFSIO_H, we are only defining
     **        close() if it has not already been defined.
     ** --------------------------------------------------------------------
     D/if not defined(CLOSE_PROTOTYPE)
     D Close           PR            10I 0 ExtProc('close')
     D   Sock_Desc                   10I 0 Value
     D/define CLOSE_PROTOTYPE
     D/endif
     D Close_Socket    PR            10I 0 ExtProc('close')
     D   Sock_Desc                   10I 0 Value


     ** --------------------------------------------------------------------
     **    shutdown()-- disable reading/writing on a socket
     **
     **    int  shutdown(int descriptor,
     **                  int how)
     **
     **    Stops all reading and/or writing on a socket.
     **    Difference between this and close() is that with close, you
     **    actually delete the descriptor, and must accept() a new one,
     **    or allocate (socket()) a new one.
     **
     **    The how parameter can be:
     **            0 = no more data can be received
     **            1 = no more data can be sent
     **            2 = no more data can be sent or received
     **
     ** --------------------------------------------------------------------
     D shutdown        PR            10I 0 ExtProc('shutdown')
     D   Sock_Desc                   10I 0 Value
     D   How                         10I 0 Value


     ** --------------------------------------------------------------------
     **  select() -- wait for events on multiple sockets
     **
     **   int select(int max_descriptor,
     **              fd_set *read_set,
     **              fd_set *write_set,
     **              fd_set *exception_set,
     **              struct timeval *wait_time)
     **
     **   Select is used to wait for i/o on multiple sockets.  This
     **   prevents your job from "blocking" on one socket read, while
     **   there is data to read on another socket.
     **
     **   It also allows you to "poll" for data to be found on a socket
     **   and to set a timeout value to keep your application from
     **   stopping forever on a "dead-end" socket.
     **
     **   ***** To help with managing the descriptor sets, I have
     **   ***** created FD_SET, FD_ISSET, FD_CLR and FD_ZERO functions
     **   ***** in my SOCKUTIL_H/SOCKUTILR4 socket utilities functions!
     **
     **   max_desriptor = The number of descriptors in your sets.
     **                   (take the highest descriptor value you want
     **                   to wait on, and add 1, and put it here)
     **
     **   read_set = A 28-byte character field specifying, on input,
     **                 which descriptors to wait for, and, on output,
     **                 which descriptors have data waiting on them.
     **                 This can be set to *NULL if you do not wish to
     **                 wait for any sockets to be read.
     **
     **  write_set = A 28-byte character field specifying, on input,
     **                 which descriptors to wait for, and, on output,
     **                 which descriptors are ready to be written to.
     **                 This can be set to *NULL if you do not wish to
     **                 wait for any sockets to be written to.
     **
     **  exception_set = A 28-byte character field specifying, on input,
     **                 which descriptors to test, and on output,
     **                 which descriptors have exceptions signalled to them.
     **                 This can be set to *NULL if you do not wish to
     **                 check for any sockets to have exceptions.
     **
     **                 NOTE: An exception is not the same as an error.
     **                       Exceptions are usually out-of-band data!
     **
     **  wait_time = a timeval data structure containing the amoutn of
     **                 time to wait for an event to occur.
     **                 If a wait time of zero is given, select() will
     **                 return immediately.
     **              If *NULL is passed instead of the timeval structure,
     **                 select() will wait indefinitely.
     **
     **  Returns the number of descriptors that met selection criteria
     **           or 0 for timeout
     **           or -1 for error.
     ** --------------------------------------------------------------------
     D Select          PR            10I 0 extproc('select')
     D   max_desc                    10I 0 VALUE
     D   read_set                      *   VALUE
     D   write_set                     *   VALUE
     D   except_set                    *   VALUE
     D   wait_Time                     *   VALUE


     ** --------------------------------------------------------------------
     **   givedescriptor() -- Pass Descriptor Access to Another Job
     **
     **   int givedescriptor(int descriptor,
     **                      char *target_job)
     **
     **   Allows you to pass a descriptor from one OS/400 job to another.
     **   (Very useful if you wanted one job to wait for incoming conn.
     **   then, submit a seperate job to deal with each client connection
     **   while the original keeps waiting for more)
     **
     **   It is the programmer's responsibility to alert the target job
     **   that it needs to take the descriptor, using takedescriptor().
     **
     **   the info for the target job can be obtained by calling a Work
     **   Managment API that supplies an "internal job identifier"
     **   (such as QUSRJOBI)
     **
     **   returns 0 = success, -1 = failure
     ** --------------------------------------------------------------------
     D givedescriptor  PR            10I 0 extproc('givedescriptor')
     D   SockDesc                    10I 0 VALUE
     D   Target_Job                    *   VALUE


     ** --------------------------------------------------------------------
     **   takedescriptor() -- Receive Descriptor Access from Another Job
     **
     **   int takedescriptor(char *source_job)
     **
     **   Allows you to pass a descriptor from one OS/400 job to another.
     **   (Very useful if you wanted one job to wait for incoming conn.
     **   then, submit a seperate job to deal with each client connection
     **   while the original keeps waiting for more)
     **
     **   the info for the source job can be obtained by calling a Work
     **   Managment API that supplies an "internal job identifier"
     **   (such as QUSRJOBI).
     **
     **   You can also specify *NULL pointer for the Source_Job parm if
     **   you want to receive a descriptor from ANY job that gives one
     **   one to you.
     **
     **   If no other jobs has referenced yours with givedescriptor()
     **   then this function will block.
     **
     **   return value is the socket descriptor taken, or -1 for error.
     ** --------------------------------------------------------------------
     D takedescriptor  PR            10I 0 extproc('takedescriptor')
     D   Source_Job                    *   VALUE


     ** --------------------------------------------------------------------
     **   gethostbyname() -- Resolves a domain name to an IP address
     **
     **      struct hostent *gethostbyname(char *host_name)
     **
     **            struct hostent {
     **              char   *h_name;
     **              char   **h_aliases;
     **              int    h_addrtype;
     **              int    h_length;
     **              char   **h_addr_list;
     **            };
     **
     **   Returns a pointer to a host entry structure.  The aliases and
     **   address list items in the structure are pointers to arrays of
     **   pointers, which are null terminated.
     **
     **   Note:  The strings & arrays used in C are often variable length,
     **       null-terminated entities.  Be careful to only use bytes from
     **       the returned pointers (in the hostent data structure) to
     **       the first null (x'00') character.
     ** --------------------------------------------------------------------
     D gethostbyname   PR              *   extProc('gethostbyname')
     D  HostName                       *   value options(*string)


     ** --------------------------------------------------------------------
     **    getservbyname()--Get Port Number for Service Name
     **
     **    struct servent *getservbyname(char *service_name,
     **                                  char *protocol_name)
     **
     **            struct servent {
     **              char   *s_name;
     **              char   **s_aliases;
     **              int    s_port;
     **              char   *s_proto;
     **            };
     **
     **   This is generally used to look up which port is used for a given
     **   internet service.   i.e. if you want to know the port for
     **   TELNET, you'd do   x = getservbyname('telnet': 'tcp')
     ** --------------------------------------------------------------------
     D getservbyname   PR              *   extproc('getservbyname')
     D   service_name                  *   value options(*string)
     D   protocol_nam                  *   value options(*string)


     ** --------------------------------------------------------------------
     **    gethostbyaddr()--Get Host Information for IP Address
     **
     **     struct hostent *gethostbyaddr(char *host_address,
     **                                   int address_length,
     **                                   int address_type)
     **         struct hostent {
     **             char   *h_name;
     **             char   **h_aliases;
     **             int    h_addrtype;
     **             int    h_length;
     **             char   **h_addr_list;
     **         };
     **
     **     An IP address (32-bit integer formnat) goes in, and a
     **     hostent structure pops out.   Really, kinda fun, if you
     **     havent already learned to hate the hostent structure, that is.
     **
     **   Note:  The strings & arrays used in C are often variable length,
     **       null-terminated entities.  use caution to only use data from
     **       the returned pointer up until the terminating null (x'00')
     **
     ** --------------------------------------------------------------------
     D gethostbyaddr   PR              *   ExtProc('gethostbyaddr')
     D  IP_Address                   10U 0
     D  Addr_Len                     10I 0 VALUE
     D  Addr_Fam                     10I 0 VALUE


     ** --------------------------------------------------------------------
     **    inet_addr()--Converts an address from dotted-decimal format
     **         to a 32-bit IP address.
     **
     **         unsigned long inet_addr(char *address_string)
     **
     **    Converts an IP address from format 192.168.0.100 to an
     **    unsigned long, such as hex x'C0A80064'.
     **
     **  returns INADDR_NONE on error.
     **
     ** KNOWN BUG: Due to the fact that this can't return a negative value,
     **              it returns x'FFFFFFFF' on error.  However, x'FFFFFFFF'
     **              is also the correct IP for the valid address of
     **              "255.255.255.255".  (which is "worldwide broadcast")
     **              A reasonable workaround is to check for 255.255.255.255
     **              beforehand, and translate it manually rather than
     **              calling inet_addr.
     ** --------------------------------------------------------------------
     D inet_addr       PR            10U 0 ExtProc('inet_addr')
     D  char_addr                      *   value options(*string)


     ** --------------------------------------------------------------------
     **    inet_ntoa()--Converts an address from 32-bit IP address to
     **         dotted-decimal format.
     **
     **         char *inet_ntoa(struct in_addr internet_address)
     **
     **    Converts from 32-bit to dotted decimal, such as, x'C0A80064'
     **    to '192.168.0.100'.  Will return NULL on error
     **
     **   Note:  The strings & arrays used in C are often variable length,
     **       null-terminated entities.  Make sure you only use bytes from
     **       the returned pointer to the first null (x'00') character.
     **
     ** --------------------------------------------------------------------
     D inet_ntoa       PR              *   ExtProc('inet_ntoa')
     D  ulong_addr                   10U 0 VALUE


     ** --------------------------------------------------------------------
     **   fcntl()--Change Descriptor Attributes
     **
     **   int fcntl(int descriptor, int command, ...)
     **
     **   The third parameter (when used with sockets) is also an
     **   integer passed by value.. it specifies an argument for
     **   some of the commands.
     **
     **   commands supported in sockets are:
     **          F_GETFL -- Return the status flags for the descriptor
     **          F_SETFL -- Set status flags for the descriptor
     **                    (Arg =)status flags (ORed) to set.
     ** (the commands below arent terribly useful in RPG)
     **          F_DUPFD -- Duplicate the descriptor
     **                    (Arg =)minimum value that new descriptor can be
     **          F_GETOWN -- Return the process ID or group ID that's
     **                     set to receive SIGIO & SIGURG
     **          F_SETOWN -- Set the process ID or group ID that's
     **                     to receive SIGIO & SIGURG
     **                    (Arg =)process ID (or neg value for group ID)
     **
     **  returns -1 upon error.
     **          successful values are command-specific.
     ** --------------------------------------------------------------------
     D/if not defined(FCNTL_PROTOTYPE)
     D fcntl           PR            10I 0 ExtProc('fcntl')
     D   SocketDesc                  10I 0 Value
     D   Command                     10I 0 Value
     D   Arg                         10I 0 Value Options(*NOPASS)
     D/define FCNTL_PROTOTYPE
     D/endif
