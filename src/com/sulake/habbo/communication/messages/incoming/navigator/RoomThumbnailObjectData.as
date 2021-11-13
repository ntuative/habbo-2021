package com.sulake.habbo.communication.messages.incoming.navigator
{
        public class RoomThumbnailObjectData 
    {

        private var _pos:int;
        private var _imgId:int;


        public function getCopy():RoomThumbnailObjectData
        {
            var _local_1:RoomThumbnailObjectData = new RoomThumbnailObjectData();
            _local_1._pos = this._pos;
            _local_1._imgId = this._imgId;
            return (_local_1);
        }

        public function set pos(_arg_1:int):void
        {
            this._pos = _arg_1;
        }

        public function set imgId(_arg_1:int):void
        {
            this._imgId = _arg_1;
        }

        public function get pos():int
        {
            return (_pos);
        }

        public function get imgId():int
        {
            return (_imgId);
        }


    }
}