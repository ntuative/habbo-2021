package com.codeazur.as3swf.timeline
{
    import com.codeazur.utils.StringUtils;

    public class FrameObject 
    {

        public var depth:uint;
        public var characterId:uint;
        public var className:String;
        public var _SafeStr_288:uint;
        public var lastModifiedAtIndex:uint;
        public var isKeyframe:Boolean;
        public var layer:int = -1;

        public function FrameObject(_arg_1:uint, _arg_2:uint, _arg_3:String, _arg_4:uint, _arg_5:uint=0, _arg_6:Boolean=false)
        {
            this.depth = _arg_1;
            this.characterId = _arg_2;
            this.className = _arg_3;
            this._SafeStr_288 = _arg_4;
            this.lastModifiedAtIndex = _arg_5;
            this.isKeyframe = _arg_6;
            this.layer = -1;
        }

        public function clone():FrameObject
        {
            return (new FrameObject(depth, characterId, className, _SafeStr_288, lastModifiedAtIndex, false));
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = (((((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "Depth: ") + depth) + ((layer > -1) ? ((" (Layer " + layer) + ")") : "")) + ", ") + "CharacterId: ") + characterId) + ", ");
            if (className != null)
            {
                _local_2 = (_local_2 + (("ClassName: " + className) + ", "));
            };
            _local_2 = (_local_2 + ("PlacedAt: " + _SafeStr_288));
            if (lastModifiedAtIndex)
            {
                _local_2 = (_local_2 + (", LastModifiedAt: " + lastModifiedAtIndex));
            };
            if (isKeyframe)
            {
                _local_2 = (_local_2 + ", IsKeyframe");
            };
            return (_local_2);
        }


    }
}

