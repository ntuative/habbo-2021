package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.room.object.data.LegacyStuffData;

        public class ObjectMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _dir:int = 0;
        private var _sizeX:int = 0;
        private var _sizeY:int = 0;
        private var _sizeZ:Number = 0;
        private var _type:int = 0;
        private var _extra:int = -1;
        private var _state:int = 0;
        private var _data:IStuffData = new LegacyStuffData();
        private var _expiryTime:int = 0;
        private var _usagePolicy:int;
        private var _ownerId:int = 0;
        private var _ownerName:String = "";
        private var _staticClass:String = null;
        private var _SafeStr_1818:Boolean = false;

        public function ObjectMessageData(_arg_1:int)
        {
            _id = _arg_1;
        }

        public function setReadOnly():void
        {
            _SafeStr_1818 = true;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function set x(_arg_1:Number):void
        {
            if (!_SafeStr_1818)
            {
                _x = _arg_1;
            };
        }

        public function get y():Number
        {
            return (_y);
        }

        public function set y(_arg_1:Number):void
        {
            if (!_SafeStr_1818)
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
            if (!_SafeStr_1818)
            {
                _z = _arg_1;
            };
        }

        public function get dir():int
        {
            return (_dir);
        }

        public function set dir(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _dir = _arg_1;
            };
        }

        public function get sizeX():int
        {
            return (_sizeX);
        }

        public function set sizeX(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _sizeX = _arg_1;
            };
        }

        public function get sizeY():int
        {
            return (_sizeY);
        }

        public function set sizeY(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _sizeY = _arg_1;
            };
        }

        public function get sizeZ():Number
        {
            return (_sizeZ);
        }

        public function set sizeZ(_arg_1:Number):void
        {
            if (!_SafeStr_1818)
            {
                _sizeZ = _arg_1;
            };
        }

        public function get type():int
        {
            return (_type);
        }

        public function set type(_arg_1:int):void
        {
            if (!_SafeStr_1818)
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
            if (!_SafeStr_1818)
            {
                _state = _arg_1;
            };
        }

        public function get data():IStuffData
        {
            return (_data);
        }

        public function set data(_arg_1:IStuffData):void
        {
            if (!_SafeStr_1818)
            {
                _data = _arg_1;
            };
        }

        public function get staticClass():String
        {
            return (_staticClass);
        }

        public function set staticClass(_arg_1:String):void
        {
            if (!_SafeStr_1818)
            {
                _staticClass = _arg_1;
            };
        }

        public function get extra():int
        {
            return (_extra);
        }

        public function set extra(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _extra = _arg_1;
            };
        }

        public function get expiryTime():int
        {
            return (_expiryTime);
        }

        public function set expiryTime(_arg_1:int):void
        {
            if (!_SafeStr_1818)
            {
                _expiryTime = _arg_1;
            };
        }

        public function get usagePolicy():int
        {
            return (_usagePolicy);
        }

        public function set usagePolicy(_arg_1:int):void
        {
            _usagePolicy = _arg_1;
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function set ownerId(_arg_1:int):void
        {
            _ownerId = _arg_1;
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function set ownerName(_arg_1:String):void
        {
            _ownerName = _arg_1;
        }


    }
}

