package com.sulake.habbo.communication.messages.outgoing.nux
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;

        public class NewUserExperienceGetGiftsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function NewUserExperienceGetGiftsMessageComposer(_arg_1:Vector.<NewUserExperienceGetGiftsSelection>)
        {
            _SafeStr_875.push((_arg_1.length * 3));
            for each (var _local_2:NewUserExperienceGetGiftsSelection in _arg_1)
            {
                _SafeStr_875.push(_local_2.dayIndex);
                _SafeStr_875.push(_local_2.stepIndex);
                _SafeStr_875.push(_local_2.giftIndex);
            };
        }

        public function getMessageArray():Array
        {
            return (this._SafeStr_875);
        }

        public function dispose():void
        {
            this._SafeStr_875 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

