package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomThumbnailData implements IDisposable 
    {

        private var _bgImgId:int;
        private var _frontImgId:int;
        private var _objects:Array = [];
        private var _disposed:Boolean;

        public function RoomThumbnailData(_arg_1:IMessageDataWrapper)
        {
            super();
            var _local_4:int;
            var _local_3:RoomThumbnailObjectData = null;
            if (_arg_1 == null)
            {
                return;
            };
            _bgImgId = _arg_1.readInteger();
            _frontImgId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_3 = new RoomThumbnailObjectData();
                _local_3.pos = _arg_1.readInteger();
                _local_3.imgId = _arg_1.readInteger();
                _objects.push(_local_3);
                _local_4++;
            };
            if (_bgImgId == 0)
            {
                setDefaults();
            };
        }

        public function setDefaults():void
        {
            _bgImgId = 1;
            _frontImgId = 0;
            var _local_1:RoomThumbnailObjectData = new RoomThumbnailObjectData();
            _local_1.pos = 4;
            _local_1.imgId = 1;
            _objects.push(_local_1);
        }

        public function getCopy():RoomThumbnailData
        {
            var _local_1:RoomThumbnailData = new RoomThumbnailData(null);
            _local_1._bgImgId = this._bgImgId;
            _local_1._frontImgId = this._frontImgId;
            for each (var _local_2:RoomThumbnailObjectData in _objects)
            {
                _local_1._objects.push(_local_2.getCopy());
            };
            return (_local_1);
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            this._objects = null;
        }

        public function getAsString():String
        {
            var _local_1:String = (_frontImgId + ";");
            _local_1 = (_local_1 + (_bgImgId + ";"));
            for each (var _local_2:RoomThumbnailObjectData in _objects)
            {
                _local_1 = (_local_1 + (((_local_2.imgId + ",") + _local_2.pos) + ";"));
            };
            return (_local_1);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get bgImgId():int
        {
            return (_bgImgId);
        }

        public function get frontImgId():int
        {
            return (_frontImgId);
        }

        public function get objects():Array
        {
            return (_objects);
        }

        public function set bgImgId(_arg_1:int):void
        {
            _bgImgId = _arg_1;
        }

        public function set frontImgId(_arg_1:int):void
        {
            _frontImgId = _arg_1;
        }


    }
}