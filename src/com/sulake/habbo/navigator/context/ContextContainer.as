package com.sulake.habbo.navigator.context
{
    import com.sulake.habbo.navigator.HabboNewNavigator;
    import com.sulake.core.utils.Map;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.TopLevelContext;
    import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorMetaDataParser;

    public class ContextContainer 
    {

        private var _navigator:HabboNewNavigator;
        private var _SafeStr_2894:Map;
        private var _savedSearches:Vector.<SavedSearch> = new Vector.<SavedSearch>();

        public function ContextContainer(_arg_1:HabboNewNavigator)
        {
            _navigator = _arg_1;
        }

        public function hasContextFor(_arg_1:String):Boolean
        {
            if (!_SafeStr_2894)
            {
                return (false);
            };
            return (_SafeStr_2894.hasKey(_arg_1));
        }

        public function initialize(_arg_1:NavigatorMetaDataParser):void
        {
            _SafeStr_2894 = new Map();
            for each (var _local_2:TopLevelContext in _arg_1.topLevelContexts)
            {
                _SafeStr_2894.add(_local_2.searchCode, _local_2.quickLinks);
            };
        }

        public function getTopLevelSearches():Array
        {
            return (_SafeStr_2894.getKeys());
        }

        public function get savedSearches():Vector.<SavedSearch>
        {
            return (_savedSearches);
        }

        public function set savedSearches(_arg_1:Vector.<SavedSearch>):void
        {
            _savedSearches = _arg_1;
        }

        public function isReady():Boolean
        {
            return (!(_SafeStr_2894 == null));
        }


    }
}

