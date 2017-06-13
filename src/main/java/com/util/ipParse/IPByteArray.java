package com.util.ipParse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Created by panrui on 2016/4/23.
 */

public class IPByteArray {

    Logger logger = LogManager.getLogger(IPByteArray.class);

    private byte[] byteArray;

    public IPByteArray( byte[] byteArray ){
        this.byteArray = byteArray;
    }

    public void read( int position, byte[] bytes ){
        int p = position;
        for( int i=0; i<bytes.length; i++ ){
            bytes[i] = read(p);
            p++;
        }
    }

    public byte read(int position){
        return byteArray[position];
    }

}
