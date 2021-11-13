package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomEventData implements IDisposable 
    {

        private var _adId:int;
        private var _ownerAvatarId:int;
        private var _ownerAvatarName:String;
        private var _flatId:int;
        private var _categoryId:int;
        private var _eventType:int;
        private var _eventName:String;
        private var _eventDescription:String;
        private var _creationTime:String;
        private var _expirationDate:Date;
        private var _disposed:Boolean;

        public function RoomEventData(_arg_1:IMessageDataWrapper)
        {
            _adId = _arg_1.readInteger();
            _ownerAvatarId = _arg_1.readInteger();
            _ownerAvatarName = _arg_1.readString();
            _flatId = _arg_1.readInteger();
            _eventType = _arg_1.readInteger();
            _eventName = _arg_1.readString();
            _eventDescription = _arg_1.readString();
            var _local_8:int = _arg_1.readInteger();
            var _local_5:int = _arg_1.readInteger();
            var _local_9:Date = new Date();
            var _local_3:Number = _local_9.getTime();
            var _local_2:Number = ((_local_8 * 60) * 1000);
            _local_3 = (_local_3 - _local_2);
            var _local_6:Date = new Date(_local_3);
            _creationTime = ((((((((_local_6.date + "-") + _local_6.month) + "-") + _local_6.fullYear) + " ") + _local_6.hours) + ":") + _local_6.minutes);
            var _local_7:Number = _local_9.getTime();
            var _local_4:Number = ((_local_5 * 60) * 1000);
            _local_7 = (_local_7 + _local_4);
            _expirationDate = new Date(_local_7);
            _categoryId = _arg_1.readInteger();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get adId():int
        {
            return (_adId);
        }

        public function get ownerAvatarId():int
        {
            return (_ownerAvatarId);
        }

        public function get ownerAvatarName():String
        {
            return (_ownerAvatarName);
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function get eventType():int
        {
            return (_eventType);
        }

        public function get eventName():String
        {
            return (_eventName);
        }

        public function get eventDescription():String
        {
            return (_eventDescription);
        }

        public function get creationTime():String
        {
            return (_creationTime);
        }

        public function get expirationDate():Date
        {
            return (_expirationDate);
        }


    }
}