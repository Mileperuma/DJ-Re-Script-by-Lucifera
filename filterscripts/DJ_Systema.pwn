/*//CREDITS:
Lucifera Editing the script and add some more updates.. Music Streaming System for Grand Theft Auto San andreas

Jubaer for the Real Script
DracoBlue for Dini
Zeex for ZCMD
Y_Less for sscanf2
Kar for Foreach
//
*/
#define SSCANF_NO_NICE_FEATURES`

#include <a_samp>
#include <dini>
#include <zcmd>
#include <sscanf2>
#include <foreach>
#define FILE1 "DJ/%s.ini"
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_ORANGE 0xFF9900FF
#define COLOR_RED 0xFF0000FF
#define COLOR_PINK 0xFF16DCFF
#define DIALOG_DJS 1

new DJ[MAX_PLAYERS];
new PmPlayer;
public OnFilterScriptInit()
{
        print("\n==========================");
        print("     DJ SYSTEM BY Jubaer    ");
        print("============================");
        print("     Re-Script by Falcon    ");
        print("==========================\n");
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}
main()
{
}
public OnPlayerConnect(playerid)
{
    new file[MAX_PLAYERS];
    format(file, sizeof(file), FILE1, IsPlayerName(playerid));
    if(!fexist(file))
    {
    dini_Create(file);
    dini_IntSet(file, "DJ", 1);
    DJ[playerid] = dini_Int(file, "DJ");
    } else {
    DJ[playerid] = dini_Int(file, "DJ");
    }
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    new file[MAX_PLAYERS];
    format(file, sizeof(file), FILE1, IsPlayerName(playerid));
    dini_IntSet(file, "DJ", DJ[playerid]);
    DJ[playerid] = 0;
    return 1;
}
stock IsPlayerName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}
CMD:dcmds(playerid, params[])
{
    new
		player[25];
	if(DJ[playerid] == 1)
	{
    	GetPlayerName(playerid, player, MAX_PLAYER_NAME);
    	SendClientMessage(playerid, COLOR_YELLOW, "DJ Commands");
    	SendClientMessage(playerid, COLOR_WHITE, "/playsong, /stopsong, /dc, /djsay, /djs, /asksong");
	}
    if(DJ[playerid] == 1)
    {
		SendClientMessage(playerid, 0xf8F8F8FFF,"ERROR: {FFFF00}You must be a DJ membership to use this command!");
	}
    return 1;
}

CMD:stopstream(playerid, params[])
{
    new
		player[25],
		str[256];
    if(DJ[playerid] == 0)
    {
    	GetPlayerName(playerid, player, MAX_PLAYER_NAME);
    	if(DJ[playerid] == 1)
			return SendClientMessage(playerid, 0xf8F8F8FFF,"ERROR: {FFFF00}You must be a DJ membership to use this command!");
    	GetPlayerName(playerid, player, MAX_PLAYER_NAME);
    	for(new i = 0; i < MAX_PLAYERS; i++)
    	StopAudioStreamForPlayer(i);
    	format(str,sizeof(str),"{FFFF00}[DJ]:DJ {00FF9B}%s {FFFF00}has stopped music streaming",player);
    	SendClientMessageToAll(playerid,str);
	}
	return 1;
}

CMD:stopmusic(playerid, params[])
{
    SendClientMessage(playerid, COLOR_WHITE, "Music stopped.");
    StopAudioStreamForPlayer(playerid);
    return 1;
}

CMD:dc(playerid, params[])
{
    new
		Nam[MAX_PLAYERS],
		tmp2[512],
		string[256],
		player[25];

    if(DJ[playerid] == 0)
    {
    	GetPlayerName(playerid, player, MAX_PLAYER_NAME);
    	if(DJ[playerid] == 1)
		{
			SendClientMessage(playerid, 0xf8F8F8FFF,"ERROR: {FFFF00}You must be a DJ membership to use this command!");
			return 1;
		}
    	if(sscanf(params,"s[200]",tmp2))
			return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /dc [Text]");
    	GetPlayerName(playerid,Nam,sizeof(Nam));
    	format(string,sizeof(string),"DJ Chat [%s] %s",Nam,tmp2);
    	for (new a=0;a<MAX_PLAYERS;a++)
    	{
    		if(DJ[playerid] == 0)
     		{
     			SendClientMessage(a, COLOR_ORANGE, string);
       		}
		 }
	}
	if(DJ[playerid] == 1)
	{
        SendClientMessage(playerid, 0xf8F8F8FFF,"ERROR: {FFFF00}You must be a DJ membership to use this command!");
    }
    return 1;
}
//pawno editor download windows
CMD:reqsong(playerid, params[])
{
    new
		Nam[MAX_PLAYERS],
		tmp3[128],
		string[256],
		player[25];

	if(DJ[playerid] == 0)
	{
    	GetPlayerName(playerid, player, MAX_PLAYER_NAME);
    	if(sscanf(params,"s[200]",tmp3))
		{
			SendClientMessage(playerid,COLOR_WHITE,"USAGE: /reqsong [Text]");
			return 1;
		}
    	GetPlayerName(playerid,Nam,sizeof(Nam));
    	format(string,sizeof(string),"[DJ]Song Requested [%s] %s",Nam,tmp3);
    	for (new a=0;a<MAX_PLAYERS;a++)
    	{
    		if(DJ[playerid] == 0)
     		{
     			SendClientMessage(a, COLOR_PINK, string);
       		}
    	}
	}
	if(DJ[playerid] == 1)
	{
        SendClientMessage(playerid, 0xf8F8F8FFF,"ERROR: {FFFF00}You can't request a song while you have a DJ Membership!");
	}
    return 1;
}
/*CMD:requestsong(playerid, params[])
{
    new playername[25],str[256];
    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    if(sscanf(params, "s[200]", params)) return SendClientMessage(playerid, -1, "Usage: /Requestsong [Song_Name]");
//    GetPlayerName(playerid,Nam,sizeof(Nam));
    format(str,sizeof(str),"Song Request [%s] %s",playername,message);
    for (new a=0;a<MAX_PLAYERS;a++)
    {
            if (IsPlayerConnected(a))
        {
            if(DJ[playerid] == 1)
            {
                             SendClientMessage(a, COLOR_PINK, str);
            }
        }
    }
    return 1;
}   */
CMD:stream(playerid, params[])	{

    new
		player[25],
		str[256];
    GetPlayerName(playerid, player, MAX_PLAYER_NAME);
	if(DJ[playerid] == 0)
	{
    	if(sscanf(params, "s[200]", params))
			return SendClientMessage(playerid, -1, "Usage: /stream [link]");
 		GameTextForPlayer(PmPlayer, "~n~~n~~n~~n~~n~~n~~n~~n~~y~MUSIC STREAMING...", 3000, 3);
    	format(str,sizeof(str),"{FFFF00}[DJ]:DJ {00FF9B}%s {FFFF00}has played an song. /stopmusic to stop it",player);
    	SendClientMessageToAll(playerid,str);
    	foreach(Player, i)
    	{
    		PlayAudioStreamForPlayer(i, params);
    	}
    	return 1;
	}
	if(DJ[playerid] == 1)
	{
		SendClientMessage(playerid, 0xf8F8F8FFF,"ERROR: {FFFF00}You must be a DJ membership to use this command!");
	}
	return 1;
}

CMD:djs(playerid, params[]) {

	new
	    str[MAX_PLAYER_NAME+250],
	    Count,
	    pname[MAX_PLAYER_NAME];
 	for(new i=0; i<MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) && DJ[playerid] == 0) {
			GetPlayerName(i, pname, sizeof(pname));
   			Count++;
		}
 	}
	if(Count == 0)
	{
		SendClientMessage(playerid, 0xF8F8F8FF, "ERROR: {f00f00}There are no DJs online at the moment!");
	}
	format(str, sizeof(str),"{19F97B}%s(%i) || {FFFF00}Server DJ",pname,playerid, DJ[playerid]);
	ShowPlayerDialog(playerid, DIALOG_DJS, DIALOG_STYLE_MSGBOX, "Connected DJs", str, "Ok", "");
	return 1;
}

CMD:djsay(playerid, params[])
{
    new
		str[256],
		name[MAX_PLAYER_NAME];
		
    if(DJ[playerid] == 0)
    {
    	GetPlayerName(playerid, name, sizeof(name));
    	if(sscanf(params, "s[200]", params))
    	{
			SendClientMessage(playerid, -1, "Usage: /djsay [text]");
		}
    	format(str,sizeof(str),"{FFFF00}[DJ] || {FF0049}[%s]{FFFF00}: %s", name, params);
    	SendClientMessageToAll(playerid,str);
    	return 1;
	}
    if(DJ[playerid] == 1)
    {
		SendClientMessage(playerid, 0xf8F8F8FFF,"ERROR: {FFFF00}You must be a DJ membership to use this command!");
	}
    return 1;
}
//---------------------------------------------------------------------------------

CMD:setdj(playerid, params[])
{
        if(IsPlayerAdmin(playerid))
        {
                new
					string[MAX_PLAYERS],
					giveplayerid,
					license;
					
                if(sscanf(params, "ud", giveplayerid, license))
				{
					SendClientMessage(playerid, -1, "{FF9900}Usage: /dj [playerid] [1 - enable 0 - disable]");
					return 1;
				}
                if(!IsPlayerConnected(giveplayerid))
					return SendClientMessage(playerid, 0xf8F8F8FFF, "{FF9900}Error:{FFFF00} Inactive player id!!");
                if(license == 1)
                {
                	DJ[giveplayerid] = 0;
                	format(string, sizeof(string), "{00FF74}You have Set %s as server DJ", IsPlayerName(giveplayerid));
                	SendClientMessage(playerid, -1, string);
                	format(string, sizeof(string), "{00FF74}An Admin has Set you as server DJ.");
                	SendClientMessage(giveplayerid, -1, string);
                }
				else {
                	DJ[giveplayerid] = 1;
                	format(string, sizeof(string), "{00FF74}You have removed %s as server DJ..", IsPlayerName(giveplayerid));
                	SendClientMessage(playerid, -1, string);
                	format(string, sizeof(string), "{00FF74}An Admin has removed you as server DJ");
                	SendClientMessage(giveplayerid, -1, string);
                }
        }
        return 1;
}
// Special thanks for Jubaer to Idea of DJ system
// hope you enjoy it
// Original author Jubaer
// Re-Script Author Matheesha Ileperuma - Falcon
