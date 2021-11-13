package com.sulake.habbo.communication.messages.incoming.room.engine
{
        public class UserUpdateMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _z:Number = 0;
        private var _localZ:Number = 0;
        private var _targetX:Number = 0;
        private var _targetY:Number = 0;
        private var _targetZ:Number = 0;
        private var _dir:int = 0;
        private var _dirHead:int = 0;
        private var _SafeStr_701:Array = [];
        private var _isMoving:Boolean = false;
        private var _canStandUp:Boolean = false;

        public function UserUpdateMessageData(_arg_1:int, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:int, _arg_7:int, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:Boolean, _arg_12:Boolean, _arg_13:Array)
        {
            _id = _arg_1;
            _x = _arg_2;
            _y = _arg_3;
            _z = _arg_4;
            _localZ = _arg_5;
            _dir = _arg_6;
            _dirHead = _arg_7;
            _targetX = _arg_8;
            _targetY = _arg_9;
            _targetZ = _arg_10;
            _isMoving = _arg_11;
            _canStandUp = _arg_12;
            _SafeStr_701 = _arg_13;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get z():Number
        {
            return (_z);
        }

        public function get localZ():Number
        {
            return (_localZ);
        }

        public function get targetX():Number
        {
            return (_targetX);
        }

        public function get targetY():Number
        {
            return (_targetY);
        }

        public function get targetZ():Number
        {
            return (_targetZ);
        }

        public function get dir():int
        {
            return (_dir);
        }

        public function get dirHead():int
        {
            return (_dirHead);
        }

        public function get isMoving():Boolean
        {
            return (_isMoving);
        }

        public function get canStandUp():Boolean
        {
            return (_canStandUp);
        }

        public function get actions():Array
        {
            return (_SafeStr_701.slice());
        }


    }
}

