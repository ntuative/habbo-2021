package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class SaveRoomSettingsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function SaveRoomSettingsMessageComposer(_arg_1:SaveableRoomSettingsData)
        {
            super();
            var _local_4:Array = null;
            _SafeStr_875.push(_arg_1.roomId);
            _SafeStr_875.push(_arg_1.name);
            _SafeStr_875.push(_arg_1.description);
            _SafeStr_875.push(_arg_1.doorMode);
            _SafeStr_875.push(((_arg_1.password !== null) ? _arg_1.password : ""));
            _SafeStr_875.push(_arg_1.maximumVisitors);
            _SafeStr_875.push(_arg_1.categoryId);
            if (_arg_1.tags)
            {
                _local_4 = [];
                for each (var _local_3:String in _arg_1.tags)
                {
                    if (((_local_3) && (!(_local_3 === ""))))
                    {
                        _local_4.push(_local_3);
                    };
                };
                _SafeStr_875.push(_local_4.length);
                for each (var _local_2:String in _local_4)
                {
                    _SafeStr_875.push(_local_2);
                };
            }
            else
            {
                _SafeStr_875.push(0);
            };
            _SafeStr_875.push(_arg_1.tradeMode);
            _SafeStr_875.push(_arg_1.allowPets);
            _SafeStr_875.push(_arg_1.allowFoodConsume);
            _SafeStr_875.push(_arg_1.allowWalkThrough);
            _SafeStr_875.push(_arg_1.hideWalls);
            _SafeStr_875.push(_arg_1.wallThickness);
            _SafeStr_875.push(_arg_1.floorThickness);
            _SafeStr_875.push(_arg_1.whoCanMute);
            _SafeStr_875.push(_arg_1.whoCanKick);
            _SafeStr_875.push(_arg_1.whoCanBan);
            _SafeStr_875.push(_arg_1.chatMode);
            _SafeStr_875.push(_arg_1.chatBubbleSize);
            _SafeStr_875.push(_arg_1.chatScrollUpFrequency);
            _SafeStr_875.push(_arg_1.chatFullHearRange);
            _SafeStr_875.push(_arg_1.chatFloodSensitivity);
            _SafeStr_875.push(_arg_1.allowNavigatorDynCats);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
            _SafeStr_875 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

