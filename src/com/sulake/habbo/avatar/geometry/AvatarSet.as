package com.sulake.habbo.avatar.geometry
{
    import flash.utils.Dictionary;

    public class AvatarSet 
    {

        private var _id:String;
        private var _SafeStr_1329:Dictionary;
        private var _SafeStr_1330:Array;
        private var _SafeStr_1331:Array;
        private var _isMain:Boolean;

        public function AvatarSet(_arg_1:XML)
        {
            super();
            var _local_4:AvatarSet = null;
            _id = String(_arg_1.@id);
            var _local_3:String = String(_arg_1.@main);
            _isMain = ((_local_3 == null) ? false : parseInt(_local_3));
            _SafeStr_1329 = new Dictionary();
            _SafeStr_1330 = [];
            for each (var _local_6:XML in _arg_1.avatarset)
            {
                _local_4 = new AvatarSet(_local_6);
                _SafeStr_1329[String(_local_6.@id)] = _local_4;
            };
            for each (var _local_2:XML in _arg_1.bodypart)
            {
                _SafeStr_1330.push(String(_local_2.@id));
            };
            var _local_5:Array = _SafeStr_1330.concat();
            for each (_local_4 in _SafeStr_1329)
            {
                _local_5 = _local_5.concat(_local_4.getBodyParts());
            };
            _SafeStr_1331 = _local_5;
        }

        public function findAvatarSet(_arg_1:String):AvatarSet
        {
            if (_arg_1 == _id)
            {
                return (this);
            };
            for each (var _local_2:AvatarSet in _SafeStr_1329)
            {
                if (_local_2.findAvatarSet(_arg_1) != null)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getBodyParts():Array
        {
            return (_SafeStr_1331.concat());
        }

        public function get id():String
        {
            return (_id);
        }

        public function get isMain():Boolean
        {
            if (_isMain)
            {
                return (true);
            };
            for each (var _local_1:AvatarSet in _SafeStr_1329)
            {
                if (_local_1.isMain)
                {
                    return (true);
                };
            };
            return (false);
        }


    }
}

