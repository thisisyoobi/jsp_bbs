create database BBS;

use BBS;

create table USER(userID varchar(20), userPassword varchar(20), userName varchar(20), userGender varchar(20), userEmail varchar(50), PRIMARY KEY (userID));

create table BBS(bbsID INT, bbsTitle varchar(50), userID varchar(20), bbsDate DATETIME, bbsContent varchar(2048), bbsFileName varchar(50), bbsAvailable INT, PRIMARY KEY (bbsID));