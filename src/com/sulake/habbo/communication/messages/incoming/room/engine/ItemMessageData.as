package com.sulake.habbo.communication.messages.incoming.room.engine
{
        public class ItemMessageData 
    {

        private var _id:int = 0;
        private var _isOldFormat:Boolean = false;
        private var _wallX:int = 0;
        private var _wallY:int = 0;
        private var _localX:int = 0;
        private var _localY:int = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _dir:String = "";
        private var _type:int = 0;
        private var _state:int = 0;
        private var _data:String = "";
        private var _readonly:Boolean = false;
        private var _usagePolicy:int = 0;
        private var _ownerId:int = 0;
        private var _ownerName:String = "";
        private var _secondsToExpiration:int;

        public function ItemMessageData(_arg_1:int, _arg_2:int, _arg_3:Boolean)
        {
            _id = _arg_1;
            _type = _arg_2;
            _isOldFormat = _arg_3;
        }

        public function setReadOnly():void
        {
            _readonly = true;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get isOldFormat():Boolean
        {
            return (_isOldFormat);
        }

        public function get wallX():Number
        {
            return (_wallX);
        }

        public function set wallX(_arg_1:Number):void
        {
            if (!_readonly)
            {
                _wallX = _arg_1;
            };
        }

        public function get wallY():Number
        {
            return (_wallY);
        }

        public function set wallY(_arg_1:Number):void
        {
            if (!_readonly)
            {
                _wallY = _arg_1;
            };
        }

        public function get localX():Number
        {
            return (_localX);
        }

        public function set localX(_arg_1:Number):void
        {
            if (!_readonly)
            {
                _localX = _arg_1;
            };
        }

        public function get localY():Number
        {
            return (_localY);
        }

        public function set localY(_arg_1:Number):void
        {
            if (!_readonly)
            {
                _localY = _arg_1;
            };
        }

        public function get y():Number
        {
            return (_y);
        }

        public function set y(_arg_1:Number):void
        {
            if (!_readonly)
            {
                _y = _arg_1;
            };
        }

        public function get z():Number
        {
            return (_z);
        }

        public function set z(_arg_1:Number):void
        {
            if (!_readonly)
            {
                _z = _arg_1;
            };
        }

        public function get dir():String
        {
            return (_dir);
        }

        public function set dir(_arg_1:String):void
        {
            if (!_readonly)
            {
                _dir = _arg_1;
            };
        }

        public function get type():int
        {
            return (_type);
        }

        public function set type(_arg_1:int):void
        {
            if (!_readonly)
            {
                _type = _arg_1;
            };
        }

        public function get state():int
        {
            return (_state);
        }

        public function set state(_arg_1:int):void
        {
            if (!_readonly)
            {
                _state = _arg_1;
            };
        }

        public function get data():String
        {
            return (_data);
        }

        public function set data(_arg_1:String):void
        {
            if (!_readonly)
            {
                _data = _arg_1;
            };
        }

        public function get usagePolicy():int
        {
            return (_usagePolicy);
        }

        public function set usagePolicy(_arg_1:int):void
        {
            if (!_readonly)
            {
                _usagePolicy = _arg_1;
            };
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function set ownerId(_arg_1:int):void
        {
            if (!_readonly)
            {
                _ownerId = _arg_1;
            };
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function set ownerName(_arg_1:String):void
        {
            if (!_readonly)
            {
                _ownerName = _arg_1;
            };
        }

        public function get secondsToExpiration():int
        {
            return (_secondsToExpiration);
        }

        public function set secondsToExpiration(_arg_1:int):void
        {
            if (!_readonly)
            {
                _secondsToExpiration = _arg_1;
            };
        }


    }
}

