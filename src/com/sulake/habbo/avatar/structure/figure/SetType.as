package com.sulake.habbo.avatar.structure.figure
{
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;

    public class SetType implements ISetType 
    {

        private var _partSets:Map;
        private var _type:String;
        private var _paletteID:int;
        private var _SafeStr_1348:Dictionary;

        public function SetType(_arg_1:XML)
        {
            _type = String(_arg_1.@type);
            _paletteID = parseInt(_arg_1.@paletteid);
            _SafeStr_1348 = new Dictionary();
            _SafeStr_1348["F"] = [];
            _SafeStr_1348["M"] = [];
            _SafeStr_1348["F"][0] = parseInt(_arg_1.@mand_f_0);
            _SafeStr_1348["F"][1] = parseInt(_arg_1.@mand_f_1);
            _SafeStr_1348["M"][0] = parseInt(_arg_1.@mand_m_0);
            _SafeStr_1348["M"][1] = parseInt(_arg_1.@mand_m_1);
            _partSets = new Map();
            append(_arg_1);
        }

        public function dispose():void
        {
            for each (var _local_1:FigurePartSet in _partSets.getValues())
            {
                _local_1.dispose();
            };
            _partSets.dispose();
            _partSets = null;
        }

        public function cleanUp(_arg_1:XML):void
        {
            var _local_3:String;
            var _local_2:FigurePartSet;
            for each (var _local_4:XML in _arg_1["set"])
            {
                _local_3 = String(_local_4.@id);
                _local_2 = _partSets.getValue(_local_3);
                if (_local_2 != null)
                {
                    _local_2.dispose();
                    _partSets.remove(_local_3);
                };
            };
        }

        public function append(_arg_1:XML):void
        {
            for each (var _local_2:XML in _arg_1["set"])
            {
                _partSets.add(String(_local_2.@id), new FigurePartSet(_local_2, _type));
            };
        }

        public function getDefaultPartSet(_arg_1:String):IFigurePartSet
        {
            var _local_4:int;
            var _local_2:IFigurePartSet;
            var _local_3:Array = _partSets.getKeys();
            _local_4 = (_local_3.length - 1);
            while (_local_4 >= 0)
            {
                _local_2 = _partSets.getValue(_local_3[_local_4]);
                if ((((_local_2) && (_local_2.clubLevel == 0)) && ((_local_2.gender == _arg_1) || (_local_2.gender == "U"))))
                {
                    return (_local_2);
                };
                _local_4--;
            };
            return (null);
        }

        public function getPartSet(_arg_1:int):IFigurePartSet
        {
            return (_partSets.getValue(String(_arg_1)));
        }

        public function get type():String
        {
            return (_type);
        }

        public function get paletteID():int
        {
            return (_paletteID);
        }

        public function isMandatory(_arg_1:String, _arg_2:int):Boolean
        {
            return (_SafeStr_1348[_arg_1.toUpperCase()][Math.min(_arg_2, 1)]);
        }

        public function optionalFromClubLevel(_arg_1:String):int
        {
            var _local_2:Array = _SafeStr_1348[_arg_1.toUpperCase()];
            return (_local_2.indexOf(false));
        }

        public function get partSets():Map
        {
            return (_partSets);
        }


    }
}

