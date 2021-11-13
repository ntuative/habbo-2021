package com.sulake.habbo.session
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageEvent;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEvent;
    import com.sulake.habbo.communication.messages.parser.perk.Perk;
    import com.sulake.habbo.session.events.PerksUpdatedEvent;

    public class PerkManager implements IDisposable 
    {

        private var _isReady:Boolean = false;
        private var _sessionDataManager:SessionDataManager;
        private var _perkAllowancesMessageEvent:IMessageEvent;
        private var _SafeStr_2071:Dictionary = new Dictionary();

        public function PerkManager(_arg_1:SessionDataManager)
        {
            _sessionDataManager = _arg_1;
            if (_sessionDataManager.communication)
            {
                _perkAllowancesMessageEvent = _sessionDataManager.communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
            };
        }

        public function get disposed():Boolean
        {
            return (_sessionDataManager == null);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_2071)
            {
                for (var _local_1:String in _SafeStr_2071)
                {
                    delete _SafeStr_2071[_local_1];
                };
                _SafeStr_2071 = null;
            };
            if (_sessionDataManager.communication)
            {
                _sessionDataManager.communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
            };
            _perkAllowancesMessageEvent = null;
            _sessionDataManager = null;
        }

        public function get isReady():Boolean
        {
            return (_isReady);
        }

        public function isPerkAllowed(_arg_1:String):Boolean
        {
            return ((_arg_1 in _SafeStr_2071) && (_SafeStr_2071[_arg_1].isAllowed));
        }

        public function getPerkErrorMessage(_arg_1:String):String
        {
            var _local_2:Perk = _SafeStr_2071[_arg_1];
            return ((_local_2 != null) ? _local_2.errorMessage : "");
        }

        private function onPerkAllowances(_arg_1:PerkAllowancesMessageEvent):void
        {
            for each (var _local_2:Perk in _arg_1.getParser().getPerks())
            {
                _SafeStr_2071[_local_2.code] = _local_2;
            };
            _isReady = true;
            _sessionDataManager.events.dispatchEvent(new PerksUpdatedEvent());
        }


    }
}

