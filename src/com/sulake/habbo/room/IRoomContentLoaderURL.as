package com.sulake.habbo.room
{
    public /*dynamic*/ interface IRoomContentLoaderURL 
    {

        function get url():String;
        function get cacheKey():String;
        function get cacheRevision():String;
        function get assetName():String;
        function get fileType():String;

    }
}