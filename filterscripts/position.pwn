#define FILTERSCRIPT

#include <a_samp>

#if defined FILTERSCRIPT

public OnFilterScriptInit(){
	print("FILTERSCRIPT 'positions.amx' CARREGADA COM SUCESSO.");
    return true;
}

public OnPlayerCommandText(playerid, cmdtext[]){
	new cmd[128],idx;
	cmd = strtok(cmdtext, idx);

	if (strcmp(cmd, "/SavePos", true) == 0){
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new text[30];
		while ((idx < length) && ((idx - offset) < (sizeof(text) - 1)))
		{
			text[idx - offset] = cmdtext[idx];
			idx++;
		}
		text[idx - offset] = EOS;
		if(!strlen(text)){
			static Float:Pos[4], str[250];
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
			GetPlayerFacingAngle(playerid, Pos[3]);

			if (!IsPlayerInAnyVehicle(playerid)) {
			    format(str, sizeof(str), "AddPlayerClass(%d, %f, %f, %f, %f, 0, 0, 0, 0, 0, 0);", GetPlayerSkin(playerid), Pos[0], Pos[1], Pos[2], Pos[3]);
			    savedposition(str);
			} else {
		        format(str, sizeof str, "AddStaticVehicle(%d, %f, %f, %f, %f, 0, 0);", GetPlayerVehicleID(playerid),Pos[0],Pos[1],Pos[2],Pos[3]);
		        savedposition(str);
		    }
		    SendClientMessage(playerid, -1, "{00FF00}Posicao salva com sucesso.");
		  	return 1;
	   	} else {
			static Float:Pos[4], str[250];
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
			GetPlayerFacingAngle(playerid, Pos[3]);

		    if (!IsPlayerInAnyVehicle(playerid)){
				format(str, sizeof str, "AddPlayerClass(%d, %f, %f, %f, %f, 0, 0, 0, 0, 0, 0); //%s", GetPlayerSkin(playerid),Pos[0],Pos[1],Pos[2],Pos[3], text);
		        savedposition(str);
		    } else {
		        format(str, sizeof str, "AddStaticVehicle(%d, %f, %f, %f, %f, 0, 0); //%s", GetPlayerVehicleID(playerid),Pos[0],Pos[1],Pos[2],Pos[3], text);
		        savedposition(str);
		    }
		    SendClientMessage(playerid, -1, "{00FF00}Posicao salva com sucesso.");
			return 1;	   		
	   	}

	}
	return 0;
}

static savedposition(const string[]){
    new data[250], File:hFile;
    format(data, sizeof(data), "%s\r\n",string);
    hFile = fopen("positions.txt", io_append);
    fwrite(hFile, data);
    fclose(hFile);
    return true;
}

static strtok(const string[], &index){
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' ')){
        index++;
    }

    new offset = index;
    new result[25];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))){
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}

#endif