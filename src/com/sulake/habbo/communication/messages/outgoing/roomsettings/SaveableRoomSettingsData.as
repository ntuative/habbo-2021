package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
        public class SaveableRoomSettingsData 
    {

        private var _roomId:int;
        private var _name:String;
        private var _description:String;
        private var _doorMode:int;
        private var _password:String;
        private var _categoryId:int;
        private var _maximumVisitors:int;
        private var _tags:Array;
        private var _controllers:Array;
        private var _tradeMode:int;
        private var _allowPets:Boolean;
        private var _allowFoodConsume:Boolean;
        private var _allowWalkThrough:Boolean;
        private var _allowNavigatorDynCats:Boolean;
        private var _hideWalls:Boolean;
        private var _wallThickness:int;
        private var _floorThickness:int;
        private var _whoCanMute:int;
        private var _whoCanKick:int;
        private var _whoCanBan:int;
        private var _chatMode:int;
        private var _chatBubbleSize:int;
        private var _chatScrollUpFrequency:int;
        private var _chatFullHearRange:int;
        private var _chatFloodSensitivity:int;


        public function get tradeMode():int
        {
            return (_tradeMode);
        }

        public function set tradeMode(_arg_1:int):void
        {
            _tradeMode = _arg_1;
        }

        public function get allowPets():Boolean
        {
            return (_allowPets);
        }

        public function set allowPets(_arg_1:Boolean):void
        {
            _allowPets = _arg_1;
        }

        public function get allowFoodConsume():Boolean
        {
            return (_allowFoodConsume);
        }

        public function set allowFoodConsume(_arg_1:Boolean):void
        {
            _allowFoodConsume = _arg_1;
        }

        public function get allowWalkThrough():Boolean
        {
            return (_allowWalkThrough);
        }

        public function set allowWalkThrough(_arg_1:Boolean):void
        {
            _allowWalkThrough = _arg_1;
        }

        public function get hideWalls():Boolean
        {
            return (_hideWalls);
        }

        public function set hideWalls(_arg_1:Boolean):void
        {
            _hideWalls = _arg_1;
        }

        public function get wallThickness():int
        {
            return (_wallThickness);
        }

        public function set wallThickness(_arg_1:int):void
        {
            _wallThickness = _arg_1;
        }

        public function get floorThickness():int
        {
            return (_floorThickness);
        }

        public function set floorThickness(_arg_1:int):void
        {
            _floorThickness = _arg_1;
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function set roomId(_arg_1:int):void
        {
            _roomId = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function get description():String
        {
            return (_description);
        }

        public function set description(_arg_1:String):void
        {
            _description = _arg_1;
        }

        public function get doorMode():int
        {
            return (_doorMode);
        }

        public function set doorMode(_arg_1:int):void
        {
            _doorMode = _arg_1;
        }

        public function get password():String
        {
            return (_password);
        }

        public function set password(_arg_1:String):void
        {
            _password = _arg_1;
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function set categoryId(_arg_1:int):void
        {
            _categoryId = _arg_1;
        }

        public function get maximumVisitors():int
        {
            return (_maximumVisitors);
        }

        public function set maximumVisitors(_arg_1:int):void
        {
            _maximumVisitors = _arg_1;
        }

        public function get tags():Array
        {
            return (_tags);
        }

        public function set tags(_arg_1:Array):void
        {
            _tags = _arg_1;
        }

        public function get controllers():Array
        {
            return (_controllers);
        }

        public function set controllers(_arg_1:Array):void
        {
            _controllers = _arg_1;
        }

        public function get whoCanMute():int
        {
            return (_whoCanMute);
        }

        public function set whoCanMute(_arg_1:int):void
        {
            _whoCanMute = _arg_1;
        }

        public function get whoCanKick():int
        {
            return (_whoCanKick);
        }

        public function set whoCanKick(_arg_1:int):void
        {
            _whoCanKick = _arg_1;
        }

        public function get whoCanBan():int
        {
            return (_whoCanBan);
        }

        public function set whoCanBan(_arg_1:int):void
        {
            _whoCanBan = _arg_1;
        }

        public function get chatMode():int
        {
            return (_chatMode);
        }

        public function set chatMode(_arg_1:int):void
        {
            _chatMode = _arg_1;
        }

        public function get chatBubbleSize():int
        {
            return (_chatBubbleSize);
        }

        public function set chatBubbleSize(_arg_1:int):void
        {
            _chatBubbleSize = _arg_1;
        }

        public function get chatScrollUpFrequency():int
        {
            return (_chatScrollUpFrequency);
        }

        public function set chatScrollUpFrequency(_arg_1:int):void
        {
            _chatScrollUpFrequency = _arg_1;
        }

        public function get chatFullHearRange():int
        {
            return (_chatFullHearRange);
        }

        public function set chatFullHearRange(_arg_1:int):void
        {
            _chatFullHearRange = _arg_1;
        }

        public function get chatFloodSensitivity():int
        {
            return (_chatFloodSensitivity);
        }

        public function set chatFloodSensitivity(_arg_1:int):void
        {
            _chatFloodSensitivity = _arg_1;
        }

        public function get allowNavigatorDynCats():Boolean
        {
            return (_allowNavigatorDynCats);
        }

        public function set allowNavigatorDynCats(_arg_1:Boolean):void
        {
            _allowNavigatorDynCats = _arg_1;
        }


    }
}