package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class ActionTypes implements ElementTypeHolder 
    {

        private var _types:Array = [];

        public function ActionTypes()
        {
            this._types.push(new _SafeStr_214());
            this._types.push(new Reset());
            this._types.push(new SetFurniStateTo());
            this._types.push(new MoveFurni());
            this._types.push(new GiveScore());
            this._types.push(new Chat());
            this._types.push(new _SafeStr_211());
            this._types.push(new JoinTeam());
            this._types.push(new _SafeStr_200());
            this._types.push(new _SafeStr_218());
            this._types.push(new _SafeStr_197());
            this._types.push(new MoveToDirection());
            this._types.push(new GiveScoreToPredefinedTeam());
            this._types.push(new _SafeStr_212());
            this._types.push(new MoveFurniTo());
            this._types.push(new GiveReward());
            this._types.push(new _SafeStr_193());
            this._types.push(new KickFromRoom());
            this._types.push(new MuteUser());
            this._types.push(new BotTeleport());
            this._types.push(new BotMove());
            this._types.push(new BotTalk());
            this._types.push(new BotGiveHandItem());
            this._types.push(new BotFollowAvatar());
            this._types.push(new BotChangeFigure());
            this._types.push(new BotTalkDirectToAvatar());
        }

        public function get types():Array
        {
            return (_types);
        }

        public function getByCode(_arg_1:int):ActionType
        {
            for each (var _local_2:ActionType in _types)
            {
                if (_local_2.code == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getElementByCode(_arg_1:int):Element
        {
            return (getByCode(_arg_1));
        }

        public function acceptTriggerable(_arg_1:Triggerable):Boolean
        {
            return (!((_arg_1 as ActionDefinition) == null));
        }

        public function getKey():String
        {
            return ("action");
        }


    }
}

