//############################################
// Copyright (C) Lyrebird Software 1996-2013
// File: console.d
// Created: 2013-08-06 11:58:27
// Modified: 2013-08-06 12:16:54
//############################################

import tinyredis.redis,
       std.stdio;

/**
 * This is simple console to demonstrate Tiny Redis
 */
void main() 
{
    auto redis = new Redis();
    
    char[] buf; 
    
    write("redis > "); 
    while (stdin.readln(buf))
    {
        string cmd = cast(string)buf[0 .. $-1];
        
        if(cmd == "exit") 
            return;
        
        if(cmd.length > 0)
            try{
                auto resp = redis.send(cmd);
                writeln(resp.toDiagnosticString());
                
            }catch(RedisResponseException e)
            {
                writeln("(error) ", e.msg);
            }
        
        write("redis > ");  
    }
}
