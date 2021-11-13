package com.sulake.habbo.avatar.actions
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.utils.Dictionary;

    public class AvatarActionManager 
    {

        private var _assets:IAssetLibrary;
        private var _SafeStr_701:Dictionary;
        private var _defaultAction:ActionDefinition;

        public function AvatarActionManager(_arg_1:IAssetLibrary, _arg_2:XML)
        {
            _assets = _arg_1;
            _SafeStr_701 = new Dictionary();
            updateActions(_arg_2);
        }

        public function updateActions(_arg_1:XML):void
        {
            var _local_4:String;
            var _local_3:ActionDefinition;
            for each (var _local_2:XML in _arg_1.action)
            {
                _local_4 = String(_local_2.@state);
                if (_local_4 != "")
                {
                    _local_3 = new ActionDefinition(_local_2);
                    _SafeStr_701[_local_4] = _local_3;
                };
            };
            parseActionOffsets();
        }

        private function parseActionOffsets():void
        {
            var _local_9:ActionDefinition;
            var _local_3:String;
            var _local_7:XML;
            var _local_6:String;
            var _local_10:int;
            var _local_1:int;
            var _local_5:int;
            var _local_4:Number;
            for each (_local_9 in _SafeStr_701)
            {
                _local_3 = _local_9.state;
                if (_assets.hasAsset(("action_offset_" + _local_3)))
                {
                    _local_7 = (_assets.getAssetByName(("action_offset_" + _local_3)).content as XML);
                    for each (var _local_2:XML in _local_7.offset)
                    {
                        _local_6 = String(_local_2.@size);
                        _local_10 = parseInt(_local_2.@direction);
                        _local_1 = parseInt(_local_2.@x);
                        _local_5 = parseInt(_local_2.@y);
                        _local_4 = Number(_local_2.@z);
                        _local_9.setOffsets(_local_6, _local_10, new Array(_local_1, _local_5, _local_4));
                    };
                };
            };
        }

        public function getActionDefinition(_arg_1:String):ActionDefinition
        {
            for each (var _local_2:ActionDefinition in _SafeStr_701)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function getActionDefinitionWithState(_arg_1:String):ActionDefinition
        {
            return (_SafeStr_701[_arg_1]);
        }

        public function getDefaultAction():ActionDefinition
        {
            if (_defaultAction)
            {
                return (_defaultAction);
            };
            for each (var _local_1:ActionDefinition in _SafeStr_701)
            {
                if (_local_1.isDefault)
                {
                    _defaultAction = _local_1;
                    return (_local_1);
                };
            };
            return (null);
        }

        public function getCanvasOffsets(_arg_1:Array, _arg_2:String, _arg_3:int):Array
        {
            var _local_4:Array;
            var _local_5:ActiveActionData;
            var _local_7:ActionDefinition;
            var _local_6:int;
            _local_6 = 0;
            while (_local_6 < _arg_1.length)
            {
                _local_5 = (_arg_1[_local_6] as ActiveActionData);
                _local_7 = (_SafeStr_701[_local_5.actionType] as ActionDefinition);
                if (((!(_local_7 == null)) && (!(_local_7.getOffsets(_arg_2, _arg_3) == null))))
                {
                    _local_4 = _local_7.getOffsets(_arg_2, _arg_3);
                };
                _local_6++;
            };
            return (_local_4);
        }

        public function sortActions(_arg_1:Array):Array
        {
            var _local_4:ActionDefinition;
            _arg_1 = filterActions(_arg_1);
            var _local_2:Array = [];
            for each (var _local_3:IActiveActionData in _arg_1)
            {
                _local_4 = _SafeStr_701[_local_3.actionType];
                if (_local_4 != null)
                {
                    _local_3.definition = _local_4;
                    _local_2.push(_local_3);
                };
            };
            _local_2.sort(orderByPrecedence);
            return (_local_2);
        }

        private function filterActions(_arg_1:Array):Array
        {
            var _local_3:ActiveActionData;
            var _local_7:ActionDefinition;
            var _local_4:int;
            var _local_5:String;
            var _local_2:Array = [];
            var _local_6:Array = [];
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_3 = (_arg_1[_local_4] as ActiveActionData);
                _local_7 = (_SafeStr_701[_local_3.actionType] as ActionDefinition);
                if (_local_7 != null)
                {
                    _local_6 = _local_6.concat(_local_7.getPrevents(_local_3.actionParameter));
                };
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < _arg_1.length)
            {
                _local_3 = (_arg_1[_local_4] as ActiveActionData);
                _local_5 = _local_3.actionType;
                if (_local_3.actionType == "fx")
                {
                    _local_5 = (_local_5 + ("." + _local_3.actionParameter));
                };
                if (_local_6.indexOf(_local_5) == -1)
                {
                    _local_2.push(_local_3);
                };
                _local_4++;
            };
            return (_local_2);
        }

        private function orderByPrecedence(_arg_1:IActiveActionData, _arg_2:IActiveActionData):Number
        {
            var _local_3:Number = _arg_1.definition.precedence;
            var _local_4:Number = _arg_2.definition.precedence;
            if (_local_3 < _local_4)
            {
                return (1);
            };
            if (_local_3 > _local_4)
            {
                return (-1);
            };
            return (0);
        }


    }
}

