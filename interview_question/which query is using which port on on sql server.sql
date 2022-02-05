

USE master
GO
xp_readerrorlog 0,1, N'Server is listening on', null , NULL, NULL, N'asc' 
GO


output :
2022-02-02 08:47:30.920	spid21s	Server is listening on [ 'any' <ipv6> 1433].
2022-02-02 08:47:30.920	spid21s	Server is listening on [ 'any' <ipv4> 1433].
2022-02-02 08:47:30.940	Server	Server is listening on [ 'any' <ipv6> 1434].
2022-02-02 08:47:30.940	Server	Server is listening on [ 'any' <ipv4> 1434].
2022-02-02 08:47:30.950	spid21s	Server is listening on [ ::1 <ipv6> 60838].
2022-02-02 08:47:30.950	spid21s	Server is listening on [ 127.0.0.1 <ipv4> 60838].
2022-02-02 08:47:33.410	spid22s	Server is listening on [ 'any' <ipv6> 5022].
2022-02-02 08:47:33.410	spid22s	Server is listening on [ 'any' <ipv4> 5022].    
