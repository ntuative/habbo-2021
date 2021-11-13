package com.sulake.habbo.avatar.structure.figure
{
    public class FigurePartSet implements IFigurePartSet
    {

        private var _type:String;
        private var _id:int;
        private var _gender:String;
        private var _clubLevel:int;
        private var _isColorable:Boolean;
        private var _isSelectable:Boolean;
        private var _parts:Array;
        private var _hiddenLayers:Array;
        private var _isPreSelectable:Boolean;
        private var _isSellable:Boolean;

        public function FigurePartSet(_arg_1:XML, _arg_2:String)
        {
            super();
            var _local_3:FigurePart = null;
            var _local_5:int;
            _type = _arg_2;
            _id = parseInt(_arg_1.@id);
            _gender = String(_arg_1.@gender);
            _clubLevel = parseInt(_arg_1.@club);
            _isColorable = !!parseInt(_arg_1.@colorable);
            _isSelectable = !!parseInt(_arg_1.@selectable);
            _isPreSelectable = !!parseInt(_arg_1.@preselectable);
            _isSellable = !!parseInt(_arg_1.@sellable);
            _parts = [];
            _hiddenLayers = [];
            for each (var _local_4:XML in _arg_1.part)
            {
                _local_3 = new FigurePart(_local_4);
                _local_5 = indexOfPartType(_local_3);
                if (_local_5 != -1)
                {
                    _parts.splice(_local_5, 0, _local_3);
                }
                else
                {
                    _parts.push(_local_3);
                };
            };
            for each (var _local_6:XML in _arg_1.hiddenlayers.layer)
            {
                _hiddenLayers.push(String(_local_6.@parttype));
            };
        }

        public function dispose():void
        {
            for each (var _local_1:FigurePart in _parts)
            {
                _local_1.dispose();
            };
            _parts = null;
            _hiddenLayers = null;
        }

        private function indexOfPartType(_arg_1:FigurePart):int
        {
            var _local_3:int;
            var _local_2:FigurePart;
            _local_3 = 0;
            while (_local_3 < _parts.length)
            {
                _local_2 = _parts[_local_3];
                if (((_local_2.type == _arg_1.type) && (_local_2.index < _arg_1.index)))
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (-1);
        }

        public function getPart(_arg_1:String, _arg_2:int):IFigurePart
        {
            for each (var _local_3:FigurePart in _parts)
            {
                if (((_local_3.type == _arg_1) && (_local_3.id == _arg_2)))
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get clubLevel():int
        {
            return (_clubLevel);
        }

        public function get isColorable():Boolean
        {
            return (_isColorable);
        }

        public function get isSelectable():Boolean
        {
            return (_isSelectable);
        }

        public function get parts():Array
        {
            return (_parts);
        }

        public function get hiddenLayers():Array
        {
            return (_hiddenLayers);
        }

        public function get isPreSelectable():Boolean
        {
            return (_isPreSelectable);
        }

        public function get isSellable():Boolean
        {
            return (_isSellable);
        }


    }
}
