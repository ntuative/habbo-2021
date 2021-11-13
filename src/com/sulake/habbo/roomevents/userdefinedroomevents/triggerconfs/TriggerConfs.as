package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class TriggerConfs implements ElementTypeHolder 
    {

        private var _confs:Array = [];

        public function TriggerConfs()
        {
            this._confs.push(new AvatarSaysSomething());
            this._confs.push(new _SafeStr_210());
            this._confs.push(new _SafeStr_201());
            this._confs.push(new TriggerOnce());
            this._confs.push(new _SafeStr_202());
            this._confs.push(new TriggerPeriodically());
            this._confs.push(new AvatarEntersRoom());
            this._confs.push(new _SafeStr_191());
            this._confs.push(new _SafeStr_208());
            this._confs.push(new ScoreAchieved());
            this._confs.push(new _SafeStr_195());
            this._confs.push(new _SafeStr_190());
            this._confs.push(new _SafeStr_192());
            this._confs.push(new BotDestinationReached());
            this._confs.push(new BotAvatarReached());
        }

        public function get confs():Array
        {
            return (_confs);
        }

        public function getByCode(_arg_1:int):_SafeStr_158
        {
            for each (var _local_2:_SafeStr_158 in _confs)
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
            return (!((_arg_1 as TriggerDefinition) == null));
        }

        public function getKey():String
        {
            return ("trigger");
        }


    }
}

