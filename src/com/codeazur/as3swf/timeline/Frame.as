package com.codeazur.as3swf.timeline
{
    import flash.utils.Dictionary;
    import com.codeazur.as3swf.tags.TagPlaceObject;
    import com.codeazur.as3swf.tags.TagRemoveObject;
    import com.codeazur.utils.StringUtils;

    public class Frame 
    {

        public var frameNumber:uint = 0;
        public var _SafeStr_273:uint = 0;
        public var tagIndexEnd:uint = 0;
        public var label:String;
        protected var _SafeStr_743:Dictionary;
        protected var _objectsSortedByDepth:Array;
        protected var _characters:Array;

        public function Frame(_arg_1:uint=0, _arg_2:uint=0)
        {
            this.frameNumber = _arg_1;
            this._SafeStr_273 = _arg_2;
            _SafeStr_743 = new Dictionary();
            _characters = [];
        }

        public function get objects():Dictionary
        {
            return (_SafeStr_743);
        }

        public function get characters():Array
        {
            return (_characters);
        }

        public function getObjectsSortedByDepth():Array
        {
            var _local_3:uint;
            var _local_2:Array = [];
            if (_objectsSortedByDepth == null)
            {
                for (var _local_1:String in _SafeStr_743)
                {
                    _local_2.push(_local_1);
                };
                _local_2.sort(16);
                _objectsSortedByDepth = [];
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    _objectsSortedByDepth.push(_SafeStr_743[_local_2[_local_3]]);
                    _local_3++;
                };
            };
            return (_objectsSortedByDepth);
        }

        public function get tagCount():uint
        {
            return ((tagIndexEnd - _SafeStr_273) + 1);
        }

        public function placeObject(_arg_1:uint, _arg_2:TagPlaceObject):void
        {
            var _local_3:FrameObject = (_SafeStr_743[_arg_2.depth] as FrameObject);
            if (_local_3)
            {
                if (_arg_2.characterId == 0)
                {
                    _local_3.lastModifiedAtIndex = _arg_1;
                    _local_3.isKeyframe = false;
                }
                else
                {
                    _local_3.lastModifiedAtIndex = 0;
                    _local_3._SafeStr_288 = _arg_1;
                    _local_3.isKeyframe = true;
                    if (_arg_2.characterId != _local_3.characterId)
                    {
                        _local_3.characterId = _arg_2.characterId;
                    };
                };
            }
            else
            {
                _SafeStr_743[_arg_2.depth] = new FrameObject(_arg_2.depth, _arg_2.characterId, _arg_2.className, _arg_1, 0, true);
            };
            _objectsSortedByDepth = null;
        }

        public function removeObject(_arg_1:TagRemoveObject):void
        {
            delete _SafeStr_743[_arg_1.depth];
            _objectsSortedByDepth = null;
        }

        public function clone():Frame
        {
            var _local_2:Frame = new Frame();
            for (var _local_1:String in _SafeStr_743)
            {
                _local_2._SafeStr_743[_local_1] = FrameObject(_SafeStr_743[_local_1]).clone();
            };
            return (_local_2);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ((((((((StringUtils.repeat(_arg_1) + "[") + frameNumber) + "] ") + "Start: ") + _SafeStr_273) + ", ") + "Length: ") + tagCount);
            if (((!(label == null)) && (!(label == ""))))
            {
                _local_2 = (_local_2 + (", Label: " + label));
            };
            if (characters.length > 0)
            {
                _local_2 = (_local_2 + ((("\n" + StringUtils.repeat((_arg_1 + 2))) + "Defined CharacterIDs: ") + characters.join(", ")));
            };
            for (var _local_3:String in _SafeStr_743)
            {
                _local_2 = (_local_2 + FrameObject(_SafeStr_743[_local_3]).toString(_arg_1));
            };
            return (_local_2);
        }


    }
}

