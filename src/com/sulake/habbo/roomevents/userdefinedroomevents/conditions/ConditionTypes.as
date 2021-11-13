package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class ConditionTypes implements ElementTypeHolder 
    {

        private var _types:Array = [];

        public function ConditionTypes()
        {
            this._types.push(new _SafeStr_203());
            this._types.push(new FurnisHaveAvatars());
            this._types.push(new StatesMatch());
            this._types.push(new TimeElapsedMore());
            this._types.push(new TimeElapsedLess());
            this._types.push(new UserCountIn());
            this._types.push(new ActorIsInTeam());
            this._types.push(new HasStackedFurnis());
            this._types.push(new _SafeStr_204());
            this._types.push(new StuffsInFormation());
            this._types.push(new _SafeStr_189());
            this._types.push(new ActorIsWearingBadge());
            this._types.push(new ActorIsWearingEffect());
            this._types.push(new DontHaveStackedFurnis());
            this._types.push(new DateRangeActive());
            this._types.push(new ActorHasHandItem());
        }

        public function get types():Array
        {
            return (_types);
        }

        public function getByCode(_arg_1:int):_SafeStr_188
        {
            for each (var _local_2:_SafeStr_188 in _types)
            {
                if (_local_2.code == _arg_1)
                {
                    return (_local_2);
                };
                if (_local_2.negativeCode == _arg_1)
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
            return (!((_arg_1 as ConditionDefinition) == null));
        }

        public function getKey():String
        {
            return ("condition");
        }


    }
}

