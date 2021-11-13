package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    public class _SafeStr_189 extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.ACTOR_IS_GROUP_MEMBER);
        }

        override public function get negativeCode():int
        {
            return (_SafeStr_228.NOT_ACTOR_IS_GROUP_MEMBER);
        }


    }
}

