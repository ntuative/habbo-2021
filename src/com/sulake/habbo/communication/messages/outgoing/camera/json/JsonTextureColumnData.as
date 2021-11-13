package com.sulake.habbo.communication.messages.outgoing.camera.json
{
        public class JsonTextureColumnData 
    {

        private var _assetNames:Array = [];


        public function addAssetName(_arg_1:String):void
        {
            _assetNames.push(_arg_1);
        }

        public function get assetNames():Array
        {
            return (_assetNames);
        }


    }
}