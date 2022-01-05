package com.codeazur.as3swf
{
    import com.codeazur.as3swf.events.SWFEventDispatcher;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.tags.ITag;
    import com.codeazur.as3swf.data.SWFRawTag;
    import flash.utils.Dictionary;
    import com.codeazur.as3swf.timeline.Scene;
    import com.codeazur.as3swf.timeline.Frame;
    import com.codeazur.as3swf.timeline.Layer;
    import com.codeazur.as3swf.timeline.SoundStream;
    import flash.display.Sprite;
    import com.codeazur.as3swf.factories.ISWFTagFactory;
    import com.codeazur.as3swf.tags.TagJPEGTables;
    import com.codeazur.as3swf.factories._SafeStr_70;
    import com.codeazur.as3swf.tags.IDefinitionTag;
    import com.codeazur.as3swf.events.SWFProgressEvent;
    import flash.events.Event;
    import flash.utils.getTimer;
    import com.codeazur.as3swf.events.SWFErrorEvent;
    import com.codeazur.as3swf.data.SWFRecordHeader;
    import com.codeazur.as3swf.tags._SafeStr_54;
    import com.codeazur.as3swf.tags.TagSetBackgroundColor;
    import com.codeazur.as3swf.tags.TagPlaceObject;
    import com.codeazur.as3swf.tags.TagRemoveObject;
    import com.codeazur.as3swf.tags.TagDefineSceneAndFrameLabelData;
    import com.codeazur.as3swf.data.SWFFrameLabel;
    import com.codeazur.as3swf.data.SWFScene;
    import com.codeazur.as3swf.tags.TagFrameLabel;
    import com.codeazur.as3swf.tags.TagSoundStreamHead;
    import com.codeazur.as3swf.tags.TagSoundStreamBlock;
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.timeline.FrameObject;
    import com.codeazur.as3swf.tags.TagDefineMorphShape;
    import com.codeazur.utils.StringUtils;

    public class SWFTimelineContainer extends SWFEventDispatcher 
    {

        public static var _SafeStr_272:int = 50;
        public static var AUTOBUILD_LAYERS:Boolean = false;
        public static var EXTRACT_SOUND_STREAM:Boolean = true;

        protected var _SafeStr_745:Vector.<ITag>;
        protected var _SafeStr_746:Vector.<SWFRawTag>;
        protected var _SafeStr_747:Dictionary;
        protected var _SafeStr_734:Vector.<Scene>;
        protected var _SafeStr_748:Vector.<Frame>;
        protected var _layers:Vector.<Layer>;
        protected var _SafeStr_749:SoundStream;
        protected var currentFrame:Frame;
        protected var frameLabels:Dictionary;
        protected var hasSoundStream:Boolean = false;
        protected var enterFrameProvider:Sprite;
        protected var eof:Boolean;
        protected var _SafeStr_750:SWFData;
        protected var _tmpVersion:uint;
        protected var _SafeStr_751:int = 0;
        protected var _SafeStr_752:ISWFTagFactory;
        internal var _SafeStr_271:SWFTimelineContainer;
        public var backgroundColor:uint = 0xFFFFFF;
        public var jpegTablesTag:TagJPEGTables;

        public function SWFTimelineContainer()
        {
            _SafeStr_745 = new Vector.<ITag>();
            _SafeStr_746 = new Vector.<SWFRawTag>();
            _SafeStr_747 = new Dictionary();
            _SafeStr_734 = new Vector.<Scene>();
            _SafeStr_748 = new Vector.<Frame>();
            _layers = new Vector.<Layer>();
            _SafeStr_752 = new _SafeStr_70();
            _SafeStr_271 = this;
            enterFrameProvider = new Sprite();
        }

        public function get tags():Vector.<ITag>
        {
            return (_SafeStr_745);
        }

        public function get tagsRaw():Vector.<SWFRawTag>
        {
            return (_SafeStr_746);
        }

        public function get dictionary():Dictionary
        {
            return (_SafeStr_747);
        }

        public function get scenes():Vector.<Scene>
        {
            return (_SafeStr_734);
        }

        public function get frames():Vector.<Frame>
        {
            return (_SafeStr_748);
        }

        public function get layers():Vector.<Layer>
        {
            return (_layers);
        }

        public function get soundStream():SoundStream
        {
            return (_SafeStr_749);
        }

        public function get tagFactory():ISWFTagFactory
        {
            return (_SafeStr_752);
        }

        public function set tagFactory(_arg_1:ISWFTagFactory):void
        {
            _SafeStr_752 = _arg_1;
        }

        public function getCharacter(_arg_1:uint):IDefinitionTag
        {
            var _local_2:int = _SafeStr_271.dictionary[_arg_1];
            if (((_local_2 >= 0) && (_local_2 < _SafeStr_271.tags.length)))
            {
                return (_SafeStr_271.tags[_local_2] as IDefinitionTag);
            };
            return (null);
        }

        public function parseTags(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:ITag;
            parseTagsInit(_arg_1, _arg_2);
            do 
            {
                _local_3 = parseTag(_arg_1);
            } while (((_local_3) && (!(_local_3.type == 0))));
            parseTagsFinalize();
        }

        public function parseTagsAsync(_arg_1:SWFData, _arg_2:uint):void
        {
            parseTagsInit(_arg_1, _arg_2);
            enterFrameProvider.addEventListener("enterFrame", parseTagsAsyncHandler);
        }

        protected function parseTagsAsyncHandler(_arg_1:Event):void
        {
            enterFrameProvider.removeEventListener("enterFrame", parseTagsAsyncHandler);
            if (dispatchEvent(new SWFProgressEvent("progress", _SafeStr_750.position, _SafeStr_750.length, false, true)))
            {
                parseTagsAsyncInternal();
            };
        }

        protected function parseTagsAsyncInternal():void
        {
            var _local_1:ITag = parseTag(_SafeStr_750, true);
            var _local_2:int = getTimer();
            while (_local_1.type != 0)
            {
                if ((getTimer() - _local_2) > _SafeStr_272)
                {
                    enterFrameProvider.addEventListener("enterFrame", parseTagsAsyncHandler);
                    return;
                };
            };
            parseTagsFinalize();
            if (eof)
            {
                dispatchEvent(new SWFErrorEvent("error", "eof"));
            }
            else
            {
                dispatchEvent(new SWFProgressEvent("progress", _SafeStr_750.position, _SafeStr_750.length));
                dispatchEvent(new SWFProgressEvent("complete", _SafeStr_750.position, _SafeStr_750.length));
            };
        }

        protected function parseTagsInit(_arg_1:SWFData, _arg_2:uint):void
        {
            tags.length = 0;
            frames.length = 0;
            layers.length = 0;
            _SafeStr_747 = new Dictionary();
            currentFrame = new Frame();
            frameLabels = new Dictionary();
            hasSoundStream = false;
            _SafeStr_750 = _arg_1;
            _tmpVersion = _arg_2;
        }

        protected function parseTag(_arg_1:SWFData, _arg_2:Boolean=false):ITag
        {
            var _local_7:SWFTimelineContainer;
            var _local_3:uint = _arg_1.position;
            eof = (_local_3 >= _arg_1.length);
            if (eof)
            {
                (trace("WARNING: end of file encountered, no end tag."));
                return (null);
            };
            var _local_4:SWFRawTag = _arg_1.readRawTag();
            var _local_5:SWFRecordHeader = _local_4.header;
            var _local_6:ITag = tagFactory.create(_local_5.type);
            try
            {
                if ((_local_6 is SWFTimelineContainer))
                {
                    _local_7 = (_local_6 as SWFTimelineContainer);
                    _local_7.tagFactory = tagFactory;
                    _local_7._SafeStr_271 = this;
                };
                _local_6.parse(_arg_1, _local_5.contentLength, _tmpVersion, _arg_2);
            }
            catch(e:Error)
            {
                (trace(((((("WARNING: parse error: " + e.message) + ", Tag: ") + _local_6.name) + ", Index: ") + tags.length)));
                throw (e);
            };
            tags.push(_local_6);
            tagsRaw.push(_local_4);
            processTag(_local_6);
            if (_arg_1.position != (_local_3 + _local_5.tagLength))
            {
                (trace(((((((("WARNING: excess bytes: " + (_arg_1.position - (_local_3 + _local_5.tagLength))) + ", ") + "Tag: ") + _local_6.name) + ", ") + "Index: ") + (tags.length - 1))));
                _arg_1.position = (_local_3 + _local_5.tagLength);
            };
            return (_local_6);
        }

        protected function parseTagsFinalize():void
        {
            if (((soundStream) && (soundStream.data.length == 0)))
            {
                _SafeStr_749 = null;
            };
            if (AUTOBUILD_LAYERS)
            {
                buildLayers();
            };
        }

        public function publishTags(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_5:ITag;
            var _local_3:SWFRawTag;
            var _local_4:uint;
            _local_4 = 0;
            while (_local_4 < tags.length)
            {
                _local_5 = tags[_local_4];
                _local_3 = ((_local_4 < tagsRaw.length) ? tagsRaw[_local_4] : null);
                publishTag(_arg_1, _local_5, _local_3, _arg_2);
                _local_4++;
            };
        }

        public function publishTagsAsync(_arg_1:SWFData, _arg_2:uint):void
        {
            _SafeStr_750 = _arg_1;
            _tmpVersion = _arg_2;
            _SafeStr_751 = 0;
            enterFrameProvider.addEventListener("enterFrame", publishTagsAsyncHandler);
        }

        protected function publishTagsAsyncHandler(_arg_1:Event):void
        {
            enterFrameProvider.removeEventListener("enterFrame", publishTagsAsyncHandler);
            if (dispatchEvent(new SWFProgressEvent("progress", _SafeStr_751, tags.length)))
            {
                publishTagsAsyncInternal();
            };
        }

        protected function publishTagsAsyncInternal():void
        {
            var _local_2:ITag;
            var _local_1:SWFRawTag;
            var _local_3:int = getTimer();
            do 
            {
                _local_2 = ((_SafeStr_751 < tags.length) ? tags[_SafeStr_751] : null);
                _local_1 = ((_SafeStr_751 < tagsRaw.length) ? tagsRaw[_SafeStr_751] : null);
                publishTag(_SafeStr_750, _local_2, _local_1, _tmpVersion);
                _SafeStr_751++;
                if ((getTimer() - _local_3) > _SafeStr_272)
                {
                    enterFrameProvider.addEventListener("enterFrame", publishTagsAsyncHandler);
                    return;
                };
            } while (_local_2.type != 0);
            dispatchEvent(new SWFProgressEvent("progress", _SafeStr_751, tags.length));
            dispatchEvent(new SWFProgressEvent("complete", _SafeStr_751, tags.length));
        }

        public function publishTag(_arg_1:SWFData, _arg_2:ITag, _arg_3:SWFRawTag, _arg_4:uint):void
        {
            try
            {
                _arg_2.publish(_arg_1, _arg_4);
            }
            catch(e:Error)
            {
                (trace((((("WARNING: publish error: " + e.message) + " (tag: ") + _arg_2.name) + ")")));
                if (_arg_3)
                {
                    _arg_3.publish(_arg_1);
                }
                else
                {
                    (trace("FATAL: publish error: No raw tag fallback"));
                };
            };
        }

        protected function processTag(_arg_1:ITag):void
        {
            var _local_2:uint = (tags.length - 1);
            if ((_arg_1 is IDefinitionTag))
            {
                processDefinitionTag((_arg_1 as IDefinitionTag), _local_2);
                return;
            };
            if ((_arg_1 is _SafeStr_54))
            {
                processDisplayListTag((_arg_1 as _SafeStr_54), _local_2);
                return;
            };
            switch (_arg_1.type)
            {
                case 43:
                case 86:
                    processFrameLabelTag(_arg_1, _local_2);
                    return;
                case 18:
                case 45:
                case 19:
                    if (EXTRACT_SOUND_STREAM)
                    {
                        processSoundStreamTag(_arg_1, _local_2);
                    };
                    return;
                case 9:
                    processBackgroundColorTag((_arg_1 as TagSetBackgroundColor), _local_2);
                    return;
                case 8:
                    processJPEGTablesTag((_arg_1 as TagJPEGTables), _local_2);
                    return;
            };
        }

        protected function processDefinitionTag(_arg_1:IDefinitionTag, _arg_2:uint):void
        {
            if (_arg_1.characterId > 0)
            {
                dictionary[_arg_1.characterId] = _arg_2;
                currentFrame.characters.push(_arg_1.characterId);
            };
        }

        protected function processDisplayListTag(_arg_1:_SafeStr_54, _arg_2:uint):void
        {
            switch (_arg_1.type)
            {
                case 1:
                    currentFrame.tagIndexEnd = _arg_2;
                    if (((currentFrame.label == null) && (frameLabels[currentFrame.frameNumber])))
                    {
                        currentFrame.label = frameLabels[currentFrame.frameNumber];
                    };
                    frames.push(currentFrame);
                    currentFrame = currentFrame.clone();
                    currentFrame.frameNumber = frames.length;
                    currentFrame._SafeStr_273 = (_arg_2 + 1);
                    return;
                case 4:
                case 26:
                case 70:
                    currentFrame.placeObject(_arg_2, (_arg_1 as TagPlaceObject));
                    return;
                case 5:
                case 28:
                    currentFrame.removeObject((_arg_1 as TagRemoveObject));
                    return;
            };
        }

        protected function processFrameLabelTag(_arg_1:ITag, _arg_2:uint):void
        {
            var _local_6:TagDefineSceneAndFrameLabelData;
            var _local_4:uint;
            var _local_5:SWFFrameLabel;
            var _local_7:SWFScene;
            var _local_3:TagFrameLabel;
            switch (_arg_1.type)
            {
                case 86:
                    _local_6 = (_arg_1 as TagDefineSceneAndFrameLabelData);
                    _local_4 = 0;
                    while (_local_4 < _local_6.frameLabels.length)
                    {
                        _local_5 = (_local_6.frameLabels[_local_4] as SWFFrameLabel);
                        frameLabels[_local_5.frameNumber] = _local_5.name;
                        _local_4++;
                    };
                    _local_4 = 0;
                    while (_local_4 < _local_6.scenes.length)
                    {
                        _local_7 = (_local_6.scenes[_local_4] as SWFScene);
                        scenes.push(new Scene(_local_7.offset, _local_7.name));
                        _local_4++;
                    };
                    return;
                case 43:
                    _local_3 = (_arg_1 as TagFrameLabel);
                    currentFrame.label = _local_3.frameName;
                    return;
            };
        }

        protected function processSoundStreamTag(_arg_1:ITag, _arg_2:uint):void
        {
            var _local_7:TagSoundStreamHead;
            var _local_4:TagSoundStreamBlock;
            var _local_6:ByteArray;
            var _local_5:uint;
            var _local_3:int;
            switch (_arg_1.type)
            {
                case 18:
                case 45:
                    _local_7 = (_arg_1 as TagSoundStreamHead);
                    _SafeStr_749 = new SoundStream();
                    soundStream.compression = _local_7.streamSoundCompression;
                    soundStream._SafeStr_275 = _local_7._SafeStr_274;
                    soundStream.size = _local_7._SafeStr_276;
                    soundStream.type = _local_7._SafeStr_277;
                    soundStream._SafeStr_278 = 0;
                    soundStream._SafeStr_279 = 0;
                    return;
                case 19:
                    if (soundStream != null)
                    {
                        if (!hasSoundStream)
                        {
                            hasSoundStream = true;
                            soundStream.startFrame = currentFrame.frameNumber;
                        };
                        _local_4 = (_arg_1 as TagSoundStreamBlock);
                        _local_6 = _local_4.soundData;
                        _local_6.endian = "littleEndian";
                        _local_6.position = 0;
                        switch (soundStream.compression)
                        {
                            case 1:
                                break;
                            case 2:
                                _local_5 = _local_6.readUnsignedShort();
                                _local_3 = _local_6.readShort();
                                if (_local_5 > 0)
                                {
                                    soundStream._SafeStr_279 = (soundStream._SafeStr_279 + _local_5);
                                    soundStream.data.writeBytes(_local_6, 4);
                                };
                            default:
                        };
                        soundStream._SafeStr_278++;
                    };
                    return;
            };
        }

        protected function processBackgroundColorTag(_arg_1:TagSetBackgroundColor, _arg_2:uint):void
        {
            backgroundColor = _arg_1.color;
        }

        protected function processJPEGTablesTag(_arg_1:TagJPEGTables, _arg_2:uint):void
        {
            jpegTablesTag = _arg_1;
        }

        public function buildLayers():void
        {
            var _local_3:uint;
            var _local_10:String;
            var _local_8:uint;
            var _local_15:Frame;
            var _local_7:Layer;
            var _local_1:Array;
            var _local_16:uint;
            var _local_14:uint;
            var _local_6:int;
            var _local_11:int;
            var _local_5:uint;
            var _local_4:uint;
            var _local_2:FrameObject;
            var _local_9:Dictionary;
            var _local_12:Dictionary = new Dictionary();
            var _local_13:Array = [];
            _local_3 = 0;
            while (_local_3 < frames.length)
            {
                _local_15 = frames[_local_3];
                for (_local_10 in _local_15.objects)
                {
                    _local_8 = parseInt(_local_10);
                    if (_local_13.indexOf(_local_8) > -1)
                    {
                        (_local_12[_local_10] as Array).push(_local_15.frameNumber);
                    }
                    else
                    {
                        _local_12[_local_10] = [_local_15.frameNumber];
                        _local_13.push(_local_8);
                    };
                };
                _local_3++;
            };
            _local_13.sort(16);
            _local_3 = 0;
            while (_local_3 < _local_13.length)
            {
                _local_7 = new Layer(_local_13[_local_3], frames.length);
                _local_1 = _local_12[_local_13[_local_3].toString()];
                _local_16 = _local_1.length;
                if (_local_16 > 0)
                {
                    _local_14 = 0;
                    _local_6 = 0xFFFFFFFF;
                    _local_11 = 0xFFFFFFFF;
                    _local_5 = 0;
                    while (_local_5 < _local_16)
                    {
                        _local_4 = _local_1[_local_5];
                        _local_2 = (frames[_local_4].objects[_local_7.depth] as FrameObject);
                        if (_local_2.isKeyframe)
                        {
                            _local_7.appendStrip(_local_14, _local_6, _local_11);
                            _local_6 = _local_4;
                            _local_14 = ((getCharacter(_local_2.characterId) is TagDefineMorphShape) ? 4 : 2);
                        }
                        else
                        {
                            if (((_local_14 == 2) && (_local_2.lastModifiedAtIndex > 0)))
                            {
                                _local_14 = 3;
                            };
                        };
                        _local_11 = _local_4;
                        _local_5++;
                    };
                    _local_7.appendStrip(_local_14, _local_6, _local_11);
                };
                _layers.push(_local_7);
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < frames.length)
            {
                _local_9 = frames[_local_3].objects;
                for (_local_10 in _local_9)
                {
                    FrameObject(_local_9[_local_10]).layer = _local_13.indexOf(parseInt(_local_10));
                };
                _local_3++;
            };
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = "";
            if (tags.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Tags:"));
                _local_3 = 0;
                while (_local_3 < tags.length)
                {
                    _local_2 = (_local_2 + ("\n" + tags[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            if (scenes.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Scenes:"));
                _local_3 = 0;
                while (_local_3 < scenes.length)
                {
                    _local_2 = (_local_2 + ("\n" + scenes[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            if (frames.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Frames:"));
                _local_3 = 0;
                while (_local_3 < frames.length)
                {
                    _local_2 = (_local_2 + ("\n" + frames[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            if (layers.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Layers:"));
                _local_3 = 0;
                while (_local_3 < layers.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + layers[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            return (_local_2);
        }

        public function dispose():void
        {
            _SafeStr_745 = null;
            _SafeStr_746 = null;
            _SafeStr_734 = null;
            _SafeStr_748 = null;
            _layers = null;
            _SafeStr_747 = null;
            _SafeStr_749 = null;
            currentFrame = null;
            frameLabels = null;
            enterFrameProvider = null;
            _SafeStr_750 = null;
            _SafeStr_752 = null;
        }


    }
}

