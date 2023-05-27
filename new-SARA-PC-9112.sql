CREATE DATABASE Eval;

GO

CREATE PROCEDURE createAllTables
AS
CREATE TABLE systemUser(
username varchar(20) PRIMARY KEY,
pass varchar(20)
); 

CREATE TABLE Stadium(
ID int PRIMARY KEY IDENTITY,
SName varchar(20),
Capacity int,
SLocation varchar(20),
Stat bit default 1
);

CREATE TABLE sportsAssociationManager(
ID int PRIMARY KEY IDENTITY,
SAMName varchar(20),
username varchar(20)
);

ALTER TABLE sportsAssociationManager
ADD CONSTRAINT fk_sam FOREIGN KEY (username) REFERENCES systemUser(username) ;

CREATE TABLE Club(
ID int PRIMARY KEY IDENTITY,
CName varchar(20) ,
CLocation varchar(20),
);

CREATE TABLE Matches (
ID int PRIMARY KEY IDENTITY,
Starttime datetime, 
Endtime datetime,
S_ID int,
HostID int,
Guest_ID int,
CONSTRAINT fk_stadm FOREIGN KEY (S_ID) REFERENCES Stadium(ID),
CONSTRAINT fk_host FOREIGN KEY (HostID) REFERENCES Club(ID) ,
CONSTRAINT fk_guest FOREIGN KEY (Guest_ID) REFERENCES Club(ID) 
);

CREATE TABLE stadiumManager(
ID int PRIMARY KEY IDENTITY,
SMName varchar(20),
username varchar(20) ,
S_ID int ,
CONSTRAINT fk_sm FOREIGN KEY (username) REFERENCES systemUser(Username) ,
CONSTRAINT fk_stadsm FOREIGN KEY (S_ID) REFERENCES Stadium (ID) 
);

CREATE TABLE clubRepresentative(
ID int PRIMARY KEY IDENTITY,
CRName varchar(20),
username varchar(20),
C_ID int,
CONSTRAINT fk_cr FOREIGN KEY (username) REFERENCES systemUser (Username) ,
CONSTRAINT fk_cidcr FOREIGN KEY (C_ID) REFERENCES Club (ID) 
);

CREATE TABLE hostRequest(
ID int PRIMARY KEY IDENTITY,
Stat varchar(20) DEFAULT 'Unhandled',
Match_ID int ,
SM_ID int,
CR_ID int,
CONSTRAINT fk_matchhr FOREIGN KEY (Match_ID) REFERENCES Matches (ID) ,
CONSTRAINT fk_smid FOREIGN KEY (SM_ID) REFERENCES stadiumManager(ID) ,
CONSTRAINT fk_crid FOREIGN KEY (CR_ID) REFERENCES clubRepresentative(ID) 
);

CREATE TABLE Fan(
NationalID varchar(20) PRIMARY KEY,
FName varchar(20),
Phoneno int,
FAddress varchar(20),
birth_date datetime,
Stat bit default 1,
username varchar(20) ,
CONSTRAINT fk_f FOREIGN KEY (username) REFERENCES systemUser(Username) 
);

CREATE TABLE systemAdmin(
ID int PRIMARY KEY IDENTITY,
SAName varchar(20),
username varchar(20),
CONSTRAINT fk_sa FOREIGN KEY (username) REFERENCES systemUser(Username) 
);

CREATE TABLE Ticket(
ID int PRIMARY KEY IDENTITY,
Stat bit,
M_ID int,
CONSTRAINT fk_t FOREIGN KEY (M_ID) REFERENCES Matches(ID) 
);


CREATE TABLE TicketBuyingTrans(
fan_nationalID varchar(20) ,
ticket_ID int,
CONSTRAINT fk_fnat FOREIGN KEY (fan_nationalID) REFERENCES Fan(NationalID) ,
CONSTRAINT fk_tid FOREIGN KEY (ticket_ID) REFERENCES ticket(ID) 
);

GO

CREATE PROCEDURE dropAllTables
AS
ALTER TABLE dbo.TicketBuyingTrans DROP CONSTRAINT fk_fnat, fk_tid;
ALTER TABLE dbo.Ticket DROP CONSTRAINT fk_t;
ALTER TABLE dbo.systemAdmin DROP CONSTRAINT fk_sa;
ALTER TABLE dbo.Fan DROP CONSTRAINT fk_f;
ALTER TABLE dbo.hostRequest DROP CONSTRAINT fk_matchhr, fk_smid, fk_crid;
ALTER TABLE dbo.clubRepresentative DROP CONSTRAINT fk_cr, fk_cidcr;
ALTER TABLE dbo.stadiumManager DROP CONSTRAINT fk_sm, fk_stadsm;
ALTER TABLE dbo.Matches DROP CONSTRAINT fk_stadm, fk_host, fk_guest;
ALTER TABLE dbo.sportsAssociationManager DROP CONSTRAINT fk_sam;
DROP TABLE sportsAssociationManager, Club, Matches, Stadium, hostRequest, stadiumManager, clubRepresentative, Fan, systemAdmin, Ticket, systemUser, TicketBuyingTrans;

GO

CREATE PROCEDURE clearAllTables
AS
ALTER TABLE dbo.TicketBuyingTrans DROP CONSTRAINT fk_fnat, fk_tid;
ALTER TABLE dbo.Ticket DROP CONSTRAINT fk_t;
ALTER TABLE dbo.systemAdmin DROP CONSTRAINT fk_sa;
ALTER TABLE dbo.Fan DROP CONSTRAINT fk_f;
ALTER TABLE dbo.hostRequest DROP CONSTRAINT fk_matchhr, fk_smid, fk_crid;
ALTER TABLE dbo.clubRepresentative DROP CONSTRAINT fk_cr, fk_cidcr;
ALTER TABLE dbo.stadiumManager DROP CONSTRAINT fk_sm, fk_stadsm;
ALTER TABLE dbo.Matches DROP CONSTRAINT fk_stadm, fk_host, fk_guest;
ALTER TABLE dbo.sportsAssociationManager DROP CONSTRAINT fk_sam;
TRUNCATE TABLE systemUser;
TRUNCATE TABLE stadiumManager;
TRUNCATE TABLE Stadium;
TRUNCATE TABLE Matches;
TRUNCATE TABLE Club;
TRUNCATE TABLE clubRepresentative;
TRUNCATE TABLE Ticket;
TRUNCATE TABLE hostRequest;
TRUNCATE TABLE Fan;
TRUNCATE TABLE sportsAssociationManager;
TRUNCATE TABLE systemAdmin;
TRUNCATE TABLE TicketBuyingTrans;
ALTER TABLE sportsAssociationManager ADD CONSTRAINT fk_sam FOREIGN KEY (username) REFERENCES systemUser(username);
ALTER TABLE Matches ADD CONSTRAINT fk_stadm FOREIGN KEY (S_ID) REFERENCES Stadium(ID),CONSTRAINT fk_host FOREIGN KEY (HostID) REFERENCES Club(ID),CONSTRAINT fk_guest FOREIGN KEY (Guest_ID) REFERENCES Club(ID);
ALTER TABLE stadiumManager ADD CONSTRAINT fk_sm FOREIGN KEY (username) REFERENCES systemUser(Username),CONSTRAINT fk_stadsm FOREIGN KEY (S_ID) REFERENCES Stadium (ID);
ALTER TABLE clubRepresentative ADD CONSTRAINT fk_cr FOREIGN KEY (username) REFERENCES systemUser (Username),CONSTRAINT fk_cidcr FOREIGN KEY (C_ID) REFERENCES Club (ID);
ALTER TABLE hostRequest ADD CONSTRAINT fk_matchhr FOREIGN KEY (Match_ID) REFERENCES Matches (ID),CONSTRAINT fk_smid FOREIGN KEY (SM_ID) REFERENCES stadiumManager(ID),CONSTRAINT fk_crid FOREIGN KEY (CR_ID) REFERENCES clubRepresentative(ID);
ALTER TABLE Fan ADD CONSTRAINT fk_f FOREIGN KEY (username) REFERENCES systemUser(Username);
ALTER TABLE systemAdmin ADD CONSTRAINT fk_sa FOREIGN KEY (username) REFERENCES systemUser(Username);
ALTER TABLE Ticket ADD CONSTRAINT fk_t FOREIGN KEY (M_ID) REFERENCES Matches(ID);
ALTER TABLE TicketBuyingTrans ADD CONSTRAINT fk_fnat FOREIGN KEY (fan_nationalID) REFERENCES Fan(NationalID),CONSTRAINT fk_tid FOREIGN KEY (ticket_ID) REFERENCES ticket(ID);

GO

CREATE VIEW allAssocManagers
AS
SELECT SM.username, S.pass, SM.SAMName 
FROM sportsAssociationManager SM INNER JOIN systemUser S ON SM.username=S.username;

GO

CREATE VIEW allClubRepresentatives AS
SELECT CR.username, SU.pass, CR.CRName, C.CName
FROM clubRepresentative CR
INNER JOIN systemUser SU ON CR.username=SU.username
INNER JOIN Club C ON CR.C_ID=C.ID;

GO

CREATE VIEW allStadiumManagers AS
SELECT SM.username, SU.pass, SM.SMName, S.SName
FROM stadiumManager SM
INNER JOIN systemUser SU ON SM.username=SU.username
INNER JOIN Stadium S ON S.ID=SM.S_ID;

GO

CREATE VIEW allFans AS
SELECT F.username, SU.pass, F.FName, F.NationalID, F.birth_date, F.Stat
FROM Fan F
INNER JOIN systemUser SU ON F.username=SU.username;

GO

CREATE VIEW allMatches AS
SELECT C1.CName AS Host, C2.CName AS Guest, M.Starttime
FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
               INNER JOIN Club C2 ON M.Guest_ID=C2.ID;

GO

CREATE VIEW allTickets
AS
SELECT C1.CName AS Host, C2.CName AS Guest, S.SName, M.Starttime
FROM Ticket T INNER JOIN Matches M ON T.M_ID=M.ID
     INNER JOIN Club C1 ON C1.ID=HostID
     INNER JOIN Club C2 ON C2.ID=Guest_ID
     INNER JOIN Stadium S ON S.ID=S_ID

GO

CREATE VIEW allClubs
AS
SELECT cname, clocation
FROM Club;

GO

CREATE VIEW allStadiums 
AS
SELECT sname, slocation, capacity, stat
FROM Stadium;

GO

CREATE VIEW allRequests 
AS
SELECT CR.username AS CR, SM.username AS SM, stat
FROM hostRequest H INNER JOIN clubRepresentative CR ON H.CR_ID=CR.ID
     INNER JOIN stadiumManager SM ON H.SM_ID=SM.ID;

GO

CREATE PROCEDURE addAssociationManager @name varchar(20), @username varchar(20), @pass varchar(20)
AS
INSERT INTO systemUser VALUES (@username,@pass);
INSERT INTO sportsAssociationManager (SAMName, username) VALUES (@name, @username);

GO

CREATE PROCEDURE addNewMatch @host varchar(20), @guest varchar(20), @start datetime, @end datetime
AS
DECLARE @hid INT 
SELECT @hid=C.ID
FROM Club C
WHERE C.CName=@host
DECLARE @gid INT 
SELECT @gid=C.ID
FROM Club C
WHERE C.CName=@guest
INSERT INTO Matches (Starttime, Endtime, HostID, Guest_ID) VALUES (@start, @end, @hid, @gid);

GO

CREATE VIEW clubsWithNoMatches
AS
SELECT C.Cname
FROM Club C
WHERE NOT EXISTS (SELECT C1.CName FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID) AND NOT EXISTS (SELECT C2.CName FROM Matches M INNER JOIN Club C2 ON M.Guest_ID=C2.ID);

GO

CREATE PROCEDURE deleteMatch @host varchar(20), @guest varchar(20)
AS
DECLARE @hid INT 
SELECT @hid=C.ID
FROM Club C
WHERE C.CName=@host
DECLARE @gid INT 
SELECT @gid=C.ID
FROM Club C
WHERE C.CName=@guest
DECLARE @mid INT
SELECT @mid=M.ID
FROM Matches M
WHERE M.HostID=@hid and M.Guest_ID=@gid
DELETE FROM Matches 
WHERE @hid=HostID AND @gid=Guest_ID;
DELETE FROM Ticket 
WHERE M_ID=@mid

GO

CREATE PROCEDURE deleteMatchesOnStadium @sname varchar(20)
AS
DECLARE @mid INT 
SELECT @mid=M.ID
FROM Matches M INNER JOIN Stadium S ON M.S_ID=S.ID 
WHERE S.SName=@sname and M.Starttime>GETDATE();
DELETE ROW FROM Matches M 
INNER JOIN Stadium S ON S.ID=M.S_ID
WHERE @sname=S.SName and M.Starttime>GETDATE();
DELETE FROM Ticket 
WHERE M_ID=@mid

GO



CREATE PROCEDURE addClub @cname varchar(20), @cloc varchar(20)
AS
INSERT INTO Club (CName, CLocation) VALUES (@cname, @cloc);

GO

CREATE PROCEDURE addTicket @host varchar(20), @guest varchar(20), @start datetime
AS
DECLARE @i int = 0
DECLARE @max int = 0 
DECLARE @id int = 0
SELECT @max=Capacity, @id=m.ID FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
                                                INNER JOIN Club C2 ON M.Guest_ID=C2.ID
                                                INNER JOIN Stadium S ON M.S_ID=S.ID
                                WHERE C1.CName=@host and C2.CName=@guest and M.Starttime=@start
WHILE @i< @max 
BEGIN 
INSERT INTO Ticket (Stat, M_ID) VALUES (1,@id);
SET @i = @i +1
END;

GO

CREATE PROCEDURE deleteClub @cname VARCHAR(20)
AS
DECLARE @clubid INT
DECLARE @matchid INT

SELECT @clubid = ID
FROM Club
where @cname = CName

SELECT @matchid = ID
FROM Matches
WHERE HOSTID = @clubid OR Guest_ID = @clubid

DELETE Ticket
WHERE M_ID=@matchid

DELETE Matches 
WHERE ID = @matchid

DELETE FROM Club WHERE 
  (CName = @cname)

GO

CREATE PROCEDURE addStadium @name varchar(20),@location varchar(20),@capacity int
AS
INSERT INTO stadium (sname, slocation,capacity) VALUES (@name,@location,@capacity);

GO

CREATE PROCEDURE deleteStadium @sname VARCHAR(20)
AS

DECLARE @sid INT

SELECT @sid = ID
FROM Stadium
WHERE SName = @sname

UPDATE Matches
SET S_ID = NULL
WHERE S_ID= @sid

DELETE FROM stadiumManager 
WHERE S_ID=@sid

DELETE FROM Stadium WHERE 
  (ID = @sid)

GO

CREATE PROCEDURE blockFan @nationalid varchar(20)
AS
UPDATE Fan 
SET stat = 0
WHERE nationalid=@nationalid;

GO

CREATE PROCEDURE unblockFan @nationalid varchar(20)
AS
UPDATE Fan 
SET stat = 1
WHERE nationalid=@nationalid;

GO

CREATE PROCEDURE addRepresentative @name varchar(20), @cname varchar(20), @username varchar(20), @password varchar(20)
AS
INSERT INTO systemUser VALUES (@username, @password);
INSERT INTO clubRepresentative ( crname, username) VALUES (@name, @username);
UPDATE clubRepresentative 
SET C_ID=C.ID
FROM Club C , clubRepresentative CR
WHERE C.CName=@cname and CR.username=@username;

GO
CREATE PROCEDURE avstad @starttime datetime
AS
SELECT *
FROM viewAvailableStadiumsOn (@starttime)


GO



CREATE FUNCTION viewAvailableStadiumsOn (@starttime DATETIME)
RETURNS @matches TABLE(n VARCHAR(20),l VARCHAR(20),capacity INT)
AS
BEGIN
INSERT INTO @matches 
SELECT S.SName,S.SLocation,S.Capacity
FROM Stadium S INNER JOIN Matches M ON M.S_ID=S.ID
WHERE S.Stat = 1 AND M.Starttime >= @starttime

  RETURN
END

GO

CREATE PROCEDURE viewStads @date datetime
AS
SELECT * FROM [dbo].viewAvailableStadiumsOn(@date);

GO

CREATE PROCEDURE addHostRequest @cname varchar(20), @stadname varchar(20), @starttime datetime
AS
INSERT INTO hostRequest ( Match_ID, SM_ID, CR_ID) 
SELECT M.ID, SM.ID, CR.ID FROM Matches M
INNER JOIN Club C1 ON M.HostID=C1.ID 
INNER JOIN clubRepresentative CR ON C1.ID=CR.C_ID,
Stadium S
INNER JOIN stadiumManager SM ON S.ID=SM.S_ID

where C1.cname=@cname and @stadname=S.SName and @starttime=M.Starttime and S.Stat=0;

GO

CREATE PROCEDURE CheckReq @cname varchar(20), @stadname varchar(20), @starttime datetime, @success bit output
AS
BEGIN
IF EXISTS(
SELECT HR.ID
FROM hostRequest HR INNER JOIN Matches M ON HR.Match_ID=M.ID
INNER JOIN clubRepresentative CR ON HR.CR_ID=CR.ID
INNER JOIN Club C ON CR.C_ID=C.ID
INNER JOIN stadiumManager SM ON HR.SM_ID=SM.ID
INNER JOIN Stadium S ON SM.S_ID=S.ID
WHERE C.CName=@cname and S.SName=@stadname and M.Starttime=@starttime)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckRequ @host varchar(20), @guest varchar(20), @start datetime, @success bit output
AS
BEGIN
IF EXISTS(
SELECT HR.ID
FROM hostRequest HR INNER JOIN Matches M ON HR.Match_ID=M.ID
INNER JOIN Club C1 ON M.HostID=C1.ID 
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
INNER JOIN clubRepresentative CR ON HR.CR_ID=CR.ID
INNER JOIN stadiumManager SM ON HR.SM_ID=SM.ID
INNER JOIN Stadium S ON SM.S_ID=S.ID
where c1.CName=@host and C2.CName=@guest and m.Starttime=@start)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckReqacc @host varchar(20), @guest varchar(20), @start datetime, @success bit output
AS
BEGIN
IF EXISTS(
SELECT HR.ID
FROM hostRequest HR INNER JOIN Matches M ON HR.Match_ID=M.ID
INNER JOIN Club C1 ON M.HostID=C1.ID 
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
INNER JOIN clubRepresentative CR ON HR.CR_ID=CR.ID
INNER JOIN stadiumManager SM ON HR.SM_ID=SM.ID
INNER JOIN Stadium S ON SM.S_ID=S.ID
where c1.CName=@host and C2.CName=@guest and m.Starttime=@start and hr.Stat='Accepted')
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckReqrej @host varchar(20), @guest varchar(20), @start datetime, @success bit output
AS
BEGIN
IF EXISTS(
SELECT HR.ID
FROM hostRequest HR INNER JOIN Matches M ON HR.Match_ID=M.ID
INNER JOIN Club C1 ON M.HostID=C1.ID 
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
INNER JOIN clubRepresentative CR ON HR.CR_ID=CR.ID
INNER JOIN stadiumManager SM ON HR.SM_ID=SM.ID
INNER JOIN Stadium S ON SM.S_ID=S.ID
where c1.CName=@host and C2.CName=@guest and m.Starttime=@start and hr.Stat='Rejected')
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE FUNCTION allUnassignedMatches (@cname varchar(20))
RETURNS @matches TABLE (G_name varchar(20), Starttime datetime)
AS
BEGIN
INSERT INTO @matches SELECT C2.Cname, M.Starttime
                     FROM Matches M INNER JOIN Club C1 ON C1.ID=M.HostID
                                    INNER JOIN Club C2 ON C2.ID=M.Guest_ID
                     WHERE C1.Cname=@cname and M.S_ID=NULL;
RETURN;
END;

GO

CREATE PROCEDURE addStadiumManager @name varchar(20), @stadname varchar(20), @username varchar(20), @password varchar(20)
AS
INSERT INTO systemUser(username, pass) VALUES (@username, @password);
INSERT INTO stadiumManager(SMName, username) VALUES (@name, @username);
UPDATE stadiumManager
SET S_ID=S.ID
FROM Stadium S
WHERE @stadname=S.SName and username=@username;

GO

CREATE FUNCTION allPendingRequests (@username varchar(20))
RETURNS @request TABLE (CR_Name varchar(20), Guest_Name varchar(20), strarttime datetime)
AS
BEGIN
INSERT INTO @request SELECT CR.CRName, C2.CName, M.starttime
                     FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
                     INNER JOIN clubRepresentative CR ON CR.C_ID=C1.ID
                     INNER JOIN Club C2 ON M.Guest_ID=C2.ID
                     INNER JOIN Stadium S ON M.S_ID=S.ID
                     INNER JOIN stadiumManager SM ON SM.S_ID=S.ID
                     INNER JOIN hostRequest HR ON HR.CR_ID=CR.ID and HR.SM_ID=SM_ID and HR.Match_ID=M.ID
WHERE SM.username=@username and HR.Stat='Unhandled';

RETURN;
END;

GO

CREATE PROCEDURE Pending @username varchar(20)
AS
SELECT CR.CRName, C1.CName AS Host, C2.CName AS Guest,M.Starttime,M.Endtime,HR.Stat
FROM hostRequest HR INNER JOIN clubRepresentative CR ON HR.CR_ID=CR.ID
INNER JOIN Matches M ON HR.Match_ID=M.ID
INNER JOIN Club C1 ON M.HostID=C1.ID
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
INNER JOIN stadiumManager SM ON SM.ID=HR.SM_ID
WHERE SM.username=@username

GO

CREATE PROCEDURE acceptRequest @username varchar(20), @host varchar(20), @guest varchar(20),@start datetime 
AS
DECLARE @sid int 
SELECT @sid=S.ID
FROM Stadium S INNER JOIN StadiumManager SM ON S.ID=SM.S_ID
WHERE SM.username=@username
UPDATE hostRequest
SET stat= 'Accepted'
FROM hostRequest HR INNER JOIN Matches M ON HR.Match_ID=M.ID
               INNER JOIN Club C1 ON M.HostID=C1.ID
               INNER JOIN Club C2 ON M.Guest_ID=C2.ID
               INNER JOIN stadiumManager SM ON HR.SM_ID=SM.ID
WHERE SM.username=@username and c1.CName=@host and c2.CName=@guest and m.Starttime=@start and Stat='Unhandled'
UPDATE Matches
SET S_ID=@sid
FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
               INNER JOIN Club C2 ON M.Guest_ID=C2.ID
WHERE C1.CName=@host and c2.CName=@guest and m.Starttime=@start
exec addTicket @host=@host,@guest=@guest,@start=@start 

GO
CREATE PROCEDURE rejectRequest @username varchar(20), @host varchar(20), @guest varchar(20),@start datetime 
AS
UPDATE hostRequest
SET stat= 'Rejected'
FROM hostRequest HR INNER JOIN Matches M ON HR.Match_ID=M.ID
               INNER JOIN Club C1 ON M.HostID=C1.ID
               INNER JOIN Club C2 ON M.Guest_ID=C2.ID
               INNER JOIN stadiumManager SM ON HR.SM_ID=SM.ID
WHERE SM.username=@username and c1.CName=@host and c2.CName=@guest and m.Starttime=@start and Stat='Unhandled'

GO

CREATE PROCEDURE addFan @name varchar(20), @nationalid varchar(20), @birth_date datetime, @address varchar(20), @phoneno int, @password varchar(20), @username varchar(20)
AS
INSERT INTO systemUser VALUES (@username, @password)
INSERT INTO Fan (NationalID,FName,Phoneno,FAddress,birth_date,Stat,username) VALUES (@nationalid, @name, @phoneno, @address,@birth_date,1,@username);

GO


CREATE FUNCTION upcomingMatchesOfClub (@cname varchar(20))
RETURNS @match TABLE (host varchar(20), guest varchar(20), starttime datetime, endtime datetime, stad varchar(20))
AS
BEGIN
INSERT INTO @match (host,guest,starttime,endtime, stad) SELECT C1.CName AS Host, C2.CName AS Guest, M.Starttime,M.Endtime, S.SName
                   FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
                   INNER JOIN Club C2 ON M.Guest_ID=C2.ID,Stadium S 
                
                   
                   WHERE (C1.CName=@cname or c2.CName=@cname) and Starttime>GETDATE() and M.S_ID IS NOT NULL;

INSERT INTO @match (host,guest,starttime,endtime) SELECT C1.CName AS Host, C2.CName AS Guest, M.Starttime,M.Endtime
                   FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
                   INNER JOIN Club C2 ON M.Guest_ID=C2.ID
                
                   
                   WHERE (C1.CName=@cname or c2.CName=@cname) and Starttime>GETDATE() and M.S_ID IS NULL;

RETURN;
END;

GO

CREATE FUNCTION availableMatchesToAttend (@date datetime)
RETURNS @match TABLE (host varchar(20), guest varchar(20), starttime datetime, stad varchar(20))
AS
BEGIN
INSERT INTO @match SELECT C1.CName AS Host, C2.CName AS Guest, M.Starttime, S.SName 
                   FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
                   INNER JOIN Club C2 ON M.Guest_ID=C2.ID
                   INNER JOIN Stadium S ON M.S_ID=S.ID
                   INNER JOIN Ticket T ON T.M_ID=M.ID
                   WHERE M.Starttime>=@date and T.Stat=1
RETURN;
END;

GO

CREATE PROCEDURE purchaseTicket @nationalid varchar(20), @host varchar(20), @guest varchar(20), @starttime datetime
AS
INSERT INTO TicketBuyingTrans(fan_nationalID) VALUES (@nationalid)
UPDATE TicketBuyingTrans 
SET ticket_ID=(SELECT DISTINCT T.ID FROM Ticket T INNER JOIN Matches M ON T.M_ID=M.ID
                                         INNER JOIN Club C1 ON M.HostID=C1.ID
                                         INNER JOIN Club C2 ON M.Guest_ID=C2.ID
                WHERE C1.CName=@host and C2.CName=@guest and m.Starttime=@starttime and t.Stat=1)
WHERE fan_nationalID=@nationalid and ticket_ID is Null;
UPDATE Ticket
SET Stat=0
FROM TicketBuyingTrans TB
WHERE TB.fan_nationalID=@nationalid and ID=TB.ticket_ID;

GO

CREATE PROCEDURE getnational @username varchar(20), @nationalid varchar(20) output
AS
SELECT @nationalid=F.NationalID
FROM Fan F
WHERE F.username=@username


GO

CREATE PROCEDURE updateMatchHost @host varchar(20),@guest varchar(20),@start datetime
AS
DECLARE @hid int
DECLARE @gid int
DECLARE @mid int
SELECT @hid=ID FROM Club 
WHERE CName=@host
SELECT @gid=ID FROM Club 
WHERE CName=@guest
SELECT @mid=ID FROM Matches M
where M.HostID=@hid and M.Guest_ID=@gid and M.Starttime=@start
UPDATE Matches
SET Guest_ID = @hid , HostID=@gid , s_id=null
WHERE Starttime = @start AND  Guest_ID = @gid  and HostID=@hid;
DELETE FROM Ticket 
WHERE Ticket.M_ID=@mid


GO

CREATE VIEW matchesPerTeam 
AS
SELECT C.CName, Count(M.ID) AS Count
FROM Club C, Matches M 
WHERE (C.ID=HostID OR C.ID=Guest_ID) AND getdate()>M.Starttime
GROUP BY C.CName;

GO

CREATE VIEW clubsNeverMatched
AS
SELECT DISTINCT C1.CName AS Club1 ,C2.CName AS Club2
FROM Club C1, Club C2
WHERE C1.ID <> C2.ID AND NOT EXISTS( SELECT * FROM Matches 
	                                 WHERE (HostID = C1.ID AND Guest_ID= C2.ID) OR  (HostID = C2.ID AND Guest_ID= C1.ID)
                                     );

GO

CREATE FUNCTION clubsNeverPlayed (@cname varchar(20))
RETURNS @res TABLE (club varchar(20))
AS 
BEGIN
DECLARE @cid int
SELECT @cid = ID FROM Club 
WHERE CName = @Cname
INSERT INTO @res 
SELECT CName FROM Club C WHERE C.CName <> @Cname AND NOT EXISTS( SELECT * FROM Matches
WHERE (HostID =@cid AND Guest_ID= C.ID) OR  (HostID = C.ID AND Guest_ID= @cid))
RETURN;
END;


GO

CREATE FUNCTION matchWithHighestAttendance
()
RETURNS @table TABLE (HostName varchar(20), GuestName varchar(20))
AS
BEGIN 
  INSERT INTO @table
  SELECT C1.Cname , C1.Cname
  FROM Matches M INNER JOIN Ticket T ON M.ID=T.M_ID
  INNER JOIN Club C1 ON M.HostID=C1.ID 
  INNER JOIN Club C2 ON M.Guest_ID=C2.ID
  WHERE C1.ID = M.HostID AND C2.ID = M.Guest_ID AND T.M_ID IN (
SELECT TOP 1 M_ID
    FROM Ticket
    WHERE stat = 0
    GROUP BY M_ID
    ORDER BY COUNT(ID) DESC
)

RETURN
END

GO

CREATE FUNCTION matchesRankedByAttendance()
RETURNS @highattendance TABLE (HostName varchar(20), GuestName varchar(20))
AS BEGIN
DECLARE @table TABLE (m_id int, counting int);
DECLARE @count int;
INSERT INTO @table
SELECT T.M_ID , COUNT(T.ID)
  FROM Ticket T
  WHERE Stat = 0
  GROUP BY T.M_ID
  ORDER BY COUNT(T.ID) DESC
INSERT INTO @highattendance
SELECT C1.CName, C2.CName
FROM @table T INNER JOIN Matches M ON T.m_id=M.ID
INNER JOIN Club C1 ON M.HostID=C1.ID 
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
RETURN;
END;

GO

CREATE FUNCTION requestsFromClub
(@stadium_name varchar(20), @club_name varchar(20))
RETURNS @requests TABLE (HostName varchar(20), GuestName varchar(20))
AS 
BEGIN 
DECLARE @cid int 
DECLARE @rid int
DECLARE @smid int
SELECT @cid = ID FROM Club 
WHERE CName = @club_name
SELECT @rid=ID FROM clubRepresentative 
WHERE C_ID =@cid
SELECT @smid = SM.ID FROM stadiumManager SM INNER JOIN Stadium S ON SM.S_ID=S.ID
WHERE S.SName=@stadium_name

INSERT INTO @requests 
SELECT C1.CName AS HostName ,C2.CName AS GuestName 
FROM hostRequest HR , Club C1 , Club C2
RETURN;
END;


GO


CREATE PROCEDURE dropAllProceduresFunctionsViews 
AS
DROP PROCEDURE createAllTables,dropAllTables,
clearAllTables,addAssociationManager,addNewMatch,deleteMatch,
deleteMatchesOnStadium,addClub,addTicket,deleteClub,addStadium,deleteStadium,blockFan,
unblockFan,addRepresentative,addHostRequest,addStadiumManager
,acceptRequest,rejectRequest,addFan,
purchaseTicket,updateMatchHost;
DROP VIEW allAssocManagers,allClubRepresentatives,allStadiumManagers,
allFans,allMatches,allTickets,allClubs,allStadiums,allRequests,clubsWithNoMatches,
matchesPerTeam,clubsNeverMatched;
DROP FUNCTION viewAvailableStadiumsOn,allUnassignedMatches,allPendingRequests,
upcomingMatchesOfClub,availableMatchesToAttend,clubsNeverPlayed,matchWithHighestAttendance
,matchesRankedByAttendance,requestsFromClub;

GO

CREATE PROCEDURE CheckAdmin @username varchar(20), @password varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT SA.username, SU.pass
FROM systemAdmin SA INNER JOIN systemUser SU ON SA.username=SU.username
WHERE SA.username=@username and SU.pass=@password)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckSAM @username varchar(20), @password varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT SAM.username, SU.pass
FROM sportsAssociationManager SAM INNER JOIN systemUser SU ON SAM.username=SU.username
WHERE SAM.username=@username and SU.pass=@password)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckSM @username varchar(20), @password varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT SM.username, SU.pass
FROM stadiumManager SM INNER JOIN systemUser SU ON SM.username=SU.username
WHERE SM.username=@username and SU.pass=@password)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckCR @username varchar(20), @password varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT CR.username, SU.pass
FROM clubRepresentative CR INNER JOIN systemUser SU ON CR.username=SU.username
WHERE CR.username=@username and SU.pass=@password)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckF @username varchar(20), @password varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT F.username, SU.pass
FROM Fan F INNER JOIN systemUser SU ON F.username=SU.username
WHERE F.username=@username and SU.pass=@password and f.Stat=1)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckSAMu @username varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT SAM.username
FROM sportsAssociationManager SAM
WHERE SAM.username=@username )
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckSMu @username varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT SM.username
FROM stadiumManager SM
WHERE SM.username=@username )
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckFu @username varchar(20), @nationalid varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT F.NationalID
FROM Fan F
WHERE F.username=@username or f.NationalID=@nationalid)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckCRu @username varchar(20),  @success bit output
AS
BEGIN
IF EXISTS(
SELECT CR.username
FROM clubRepresentative CR 
WHERE CR.username=@username)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckClub @cname varchar(20),@cloc varchar(20),  @success bit output
AS
BEGIN
IF EXISTS(
SELECT CName, CLocation
FROM Club
WHERE CName=@cname and CLocation=@cloc)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckClubn @cname varchar(20),  @success bit output
AS
BEGIN
IF EXISTS(
SELECT CName
FROM Club
WHERE CName=@cname)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END


GO

CREATE PROCEDURE CheckStadium @sname varchar(20),@sloc varchar(20), @scap int,  @success bit output
AS
BEGIN
IF EXISTS(
SELECT SName, SLocation, Capacity
FROM Stadium
WHERE SName=@sname and SLocation=@sloc and Capacity=@scap)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckStadn @sname varchar(20),  @success bit output
AS
BEGIN
IF EXISTS(
SELECT SName
FROM Stadium
WHERE SName=@sname)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckFan @nationalid varchar(20),  @success bit output
AS
BEGIN
IF EXISTS(
SELECT NationalID
FROM Fan
WHERE NationalID=@nationalid and Stat=1)
BEGIN 
SET @success=1
END
ELSE 
SET @success=0;
END

GO

CREATE PROCEDURE CheckBlock @nationalid varchar(20), @block bit output
AS
BEGIN
IF EXISTS(
SELECT NationalID
FROM Fan
WHERE NationalID=@nationalid and Stat=0)
BEGIN
SET @block=1
END
ELSE
SET @block=0
END

GO

CREATE PROCEDURE CheckUnBlock @nationalid varchar(20), @block bit output
AS
BEGIN
IF EXISTS(
SELECT NationalID
FROM Fan
WHERE NationalID=@nationalid and Stat=1)
BEGIN
SET @block=1
END
ELSE
SET @block=0
END

GO

CREATE PROCEDURE CheckMatch @hname varchar(20), @gname varchar(20), @start datetime, @end datetime, @success bit output
AS
BEGIN
IF EXISTS(
SELECT HostID, Guest_ID, Starttime, Endtime
FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
WHERE C1.CName=@hname and C2.CName=@gname and m.Starttime=@start and m.Endtime=@end)
BEGIN
SET @success=1
END
ELSE
SET @success=0
END

GO

CREATE PROCEDURE UpcomingMatches
AS
SELECT C1.CName AS Host, C2.CName AS Guest, M.Starttime,M.Endtime
FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
WHERE Starttime>GETDATE();

GO

CREATE PROCEDURE PlayedMatches
AS
SELECT C1.CName AS Host, C2.CName AS Guest, M.Starttime,M.Endtime
FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
WHERE Endtime<GETDATE();

GO



CREATE PROCEDURE NeverMatched
AS
SELECT * FROM clubsNeverMatched

GO

CREATE PROCEDURE ClubInfo @cname varchar(20)
AS
SELECT C.CName AS cName, C.CLocation AS cLocation  
FROM club C
WHERE C.CName=@cname

GO

CREATE PROCEDURE StadInfo @sname varchar(20)
AS
SELECT S.SName AS sname, S.SLocation AS slocation, S.Capacity AS cap
FROM Stadium S
WHERE S.SName=@sname

GO

CREATE procedure upcoming @cname varchar(20)
AS
Select * from [dbo].upcomingMatchesOfClub (@cname)

GO

CREATE PROCEDURE ClubName @username varchar(20), @clubname varchar(20) output
AS
SELECT @clubname=C.CName
FROM clubRepresentative CR INNER JOIN Club C ON CR.C_ID=C.ID
WHERE CR.username=@username

GO

CREATE PROCEDURE StadName @username varchar(20), @stadname varchar(20) output
AS
SELECT @stadname=S.SName
FROM stadiumManager SM INNER JOIN Stadium S ON SM.S_ID=S.ID
WHERE SM.username=@username

GO

CREATE PROCEDURE CheckStad @host varchar(20), @guest varchar(20), @start datetime, @end datetime, @stadname varchar(20) output
AS
IF EXISTS( SELECT SName
          FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
          INNER JOIN Club C2 ON M.Guest_ID=C2.ID
          INNER JOIN Stadium S ON M.S_ID=S.ID
          WHERE C1.CName=@host and c2.CName=@guest and m.Starttime=@start and m.Endtime=@end
          )
BEGIN
SELECT @stadname=SName FROM Matches M INNER JOIN Club C1 ON M.HostID=C1.ID
          INNER JOIN Club C2 ON M.Guest_ID=C2.ID
          INNER JOIN Stadium S ON M.S_ID=S.ID
          WHERE C1.CName=@host and c2.CName=@guest and m.Starttime=@start and m.Endtime=@end
END

GO

CREATE PROCEDURE CheckClubCR @cname varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT CR.ID
FROM clubRepresentative CR INNER JOIN Club C ON CR.C_ID=C.ID
WHERE C.CName=@cname)
BEGIN
SET @success=1
END
ELSE
SET @success=0
END

GO

CREATE PROCEDURE CheckStadSM @sname varchar(20), @success bit output
AS
BEGIN
IF EXISTS(
SELECT SM.ID
FROM stadiumManager SM INNER JOIN Stadium S ON SM.S_ID=S.ID
WHERE S.SName=@sname)
BEGIN
SET @success=1
END
ELSE
SET @success=0
END

GO

CREATE PROCEDURE CheckT @host varchar(20), @guest varchar(20), @start datetime, @success bit output
AS
BEGIN
IF EXISTS(
SELECT T.ID
FROM Ticket T INNER JOIN Matches M ON T.M_ID=M.ID
INNER JOIN Club C1 ON M.HostID=C1.ID
INNER JOIN Club C2 ON M.Guest_ID=C2.ID
WHERE C1.CName=@host and c2.CName=@guest and m.Starttime=@start)
BEGIN
SET @success=1
END
ELSE 
SET @success=0
END


INSERT INTO systemUser VALUES ('sara9', 'soso');
INSERT INTO systemAdmin (SAName,username) VALUES ('sarah','sara9')

select * from Club
select * from Matches
select * from hostRequest
select * from Ticket