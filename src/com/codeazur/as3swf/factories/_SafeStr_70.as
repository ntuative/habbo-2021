package com.codeazur.as3swf.factories
{
    import com.codeazur.as3swf.tags.ITag;
    import com.codeazur.as3swf.tags.TagEnd;
    import com.codeazur.as3swf.tags.TagShowFrame;
    import com.codeazur.as3swf.tags.TagDefineShape;
    import com.codeazur.as3swf.tags.TagPlaceObject;
    import com.codeazur.as3swf.tags.TagRemoveObject;
    import com.codeazur.as3swf.tags.TagDefineBits;
    import com.codeazur.as3swf.tags.TagDefineButton;
    import com.codeazur.as3swf.tags.TagJPEGTables;
    import com.codeazur.as3swf.tags.TagSetBackgroundColor;
    import com.codeazur.as3swf.tags.TagDefineFont;
    import com.codeazur.as3swf.tags.TagDefineText;
    import com.codeazur.as3swf.tags.TagDoAction;
    import com.codeazur.as3swf.tags.TagDefineFontInfo;
    import com.codeazur.as3swf.tags.TagDefineSound;
    import com.codeazur.as3swf.tags.TagStartSound;
    import com.codeazur.as3swf.tags.TagDefineButtonSound;
    import com.codeazur.as3swf.tags.TagSoundStreamHead;
    import com.codeazur.as3swf.tags.TagSoundStreamBlock;
    import com.codeazur.as3swf.tags.TagDefineBitsLossless;
    import com.codeazur.as3swf.tags.TagDefineBitsJPEG2;
    import com.codeazur.as3swf.tags.TagDefineShape2;
    import com.codeazur.as3swf.tags.TagDefineButtonCxform;
    import com.codeazur.as3swf.tags.TagProtect;
    import com.codeazur.as3swf.tags.TagPlaceObject2;
    import com.codeazur.as3swf.tags.TagRemoveObject2;
    import com.codeazur.as3swf.tags.TagDefineShape3;
    import com.codeazur.as3swf.tags.TagDefineText2;
    import com.codeazur.as3swf.tags.TagDefineButton2;
    import com.codeazur.as3swf.tags.TagDefineBitsJPEG3;
    import com.codeazur.as3swf.tags.TagDefineBitsLossless2;
    import com.codeazur.as3swf.tags.TagDefineEditText;
    import com.codeazur.as3swf.tags.TagDefineSprite;
    import com.codeazur.as3swf.tags.TagNameCharacter;
    import com.codeazur.as3swf.tags.TagProductInfo;
    import com.codeazur.as3swf.tags.TagFrameLabel;
    import com.codeazur.as3swf.tags.TagSoundStreamHead2;
    import com.codeazur.as3swf.tags.TagDefineMorphShape;
    import com.codeazur.as3swf.tags.TagDefineFont2;
    import com.codeazur.as3swf.tags.TagExportAssets;
    import com.codeazur.as3swf.tags.TagImportAssets;
    import com.codeazur.as3swf.tags.TagEnableDebugger;
    import com.codeazur.as3swf.tags.TagDoInitAction;
    import com.codeazur.as3swf.tags.TagDefineVideoStream;
    import com.codeazur.as3swf.tags.TagVideoFrame;
    import com.codeazur.as3swf.tags.TagDefineFontInfo2;
    import com.codeazur.as3swf.tags.TagDebugID;
    import com.codeazur.as3swf.tags.TagEnableDebugger2;
    import com.codeazur.as3swf.tags.TagScriptLimits;
    import com.codeazur.as3swf.tags.TagSetTabIndex;
    import com.codeazur.as3swf.tags.TagFileAttributes;
    import com.codeazur.as3swf.tags.TagPlaceObject3;
    import com.codeazur.as3swf.tags.TagImportAssets2;
    import com.codeazur.as3swf.tags.TagDefineFontAlignZones;
    import com.codeazur.as3swf.tags.TagCSMTextSettings;
    import com.codeazur.as3swf.tags.TagDefineFont3;
    import com.codeazur.as3swf.tags.TagSymbolClass;
    import com.codeazur.as3swf.tags.TagMetadata;
    import com.codeazur.as3swf.tags.TagDefineScalingGrid;
    import com.codeazur.as3swf.tags.TagDoABC;
    import com.codeazur.as3swf.tags.TagDoABCDeprecated;
    import com.codeazur.as3swf.tags.TagDefineShape4;
    import com.codeazur.as3swf.tags.TagDefineMorphShape2;
    import com.codeazur.as3swf.tags.TagDefineSceneAndFrameLabelData;
    import com.codeazur.as3swf.tags.TagDefineBinaryData;
    import com.codeazur.as3swf.tags.TagDefineFontName;
    import com.codeazur.as3swf.tags.TagStartSound2;
    import com.codeazur.as3swf.tags.TagDefineBitsJPEG4;
    import com.codeazur.as3swf.tags.TagDefineFont4;
    import com.codeazur.as3swf.tags.TagEnableTelemetry;
    import com.codeazur.as3swf.tags.TagPlaceObject4;
    import com.codeazur.as3swf.tags.etc.TagSWFEncryptActions;
    import com.codeazur.as3swf.tags.etc.TagSWFEncryptSignature;
    import com.codeazur.as3swf.tags.TagUnknown;

    public class _SafeStr_70 implements ISWFTagFactory 
    {


        public function create(_arg_1:uint):ITag
        {
            switch (_arg_1)
            {
                case 0:
                    return (createTagEnd());
                case 1:
                    return (createTagShowFrame());
                case 2:
                    return (createTagDefineShape());
                case 4:
                    return (createTagPlaceObject());
                case 5:
                    return (createTagRemoveObject());
                case 6:
                    return (createTagDefineBits());
                case 7:
                    return (createTagDefineButton());
                case 8:
                    return (createTagJPEGTables());
                case 9:
                    return (createTagSetBackgroundColor());
                case 10:
                    return (createTagDefineFont());
                case 11:
                    return (createTagDefineText());
                case 12:
                    return (createTagDoAction());
                case 13:
                    return (createTagDefineFontInfo());
                case 14:
                    return (createTagDefineSound());
                case 15:
                    return (createTagStartSound());
                case 17:
                    return (createTagDefineButtonSound());
                case 18:
                    return (createTagSoundStreamHead());
                case 19:
                    return (createTagSoundStreamBlock());
                case 20:
                    return (createTagDefineBitsLossless());
                case 21:
                    return (createTagDefineBitsJPEG2());
                case 22:
                    return (createTagDefineShape2());
                case 23:
                    return (createTagDefineButtonCxform());
                case 24:
                    return (createTagProtect());
                case 26:
                    return (createTagPlaceObject2());
                case 28:
                    return (createTagRemoveObject2());
                case 32:
                    return (createTagDefineShape3());
                case 33:
                    return (createTagDefineText2());
                case 34:
                    return (createTagDefineButton2());
                case 35:
                    return (createTagDefineBitsJPEG3());
                case 36:
                    return (createTagDefineBitsLossless2());
                case 37:
                    return (createTagDefineEditText());
                case 39:
                    return (createTagDefineSprite());
                case 40:
                    return (createTagNameCharacter());
                case 41:
                    return (createTagProductInfo());
                case 43:
                    return (createTagFrameLabel());
                case 45:
                    return (createTagSoundStreamHead2());
                case 46:
                    return (createTagDefineMorphShape());
                case 48:
                    return (createTagDefineFont2());
                case 56:
                    return (createTagExportAssets());
                case 57:
                    return (createTagImportAssets());
                case 58:
                    return (createTagEnableDebugger());
                case 59:
                    return (createTagDoInitAction());
                case 60:
                    return (createTagDefineVideoStream());
                case 61:
                    return (createTagVideoFrame());
                case 62:
                    return (createTagDefineFontInfo2());
                case 63:
                    return (createTagDebugID());
                case 64:
                    return (createTagEnableDebugger2());
                case 65:
                    return (createTagScriptLimits());
                case 66:
                    return (createTagSetTabIndex());
                case 69:
                    return (createTagFileAttributes());
                case 70:
                    return (createTagPlaceObject3());
                case 71:
                    return (createTagImportAssets2());
                case 72:
                    return (createTagDoABCDeprecated());
                case 73:
                    return (createTagDefineFontAlignZones());
                case 74:
                    return (createTagCSMTextSettings());
                case 75:
                    return (createTagDefineFont3());
                case 76:
                    return (createTagSymbolClass());
                case 77:
                    return (createTagMetadata());
                case 78:
                    return (createTagDefineScalingGrid());
                case 82:
                    return (createTagDoABC());
                case 83:
                    return (createTagDefineShape4());
                case 84:
                    return (createTagDefineMorphShape2());
                case 86:
                    return (createTagDefineSceneAndFrameLabelData());
                case 87:
                    return (createTagDefineBinaryData());
                case 88:
                    return (createTagDefineFontName());
                case 89:
                    return (createTagStartSound2());
                case 90:
                    return (createTagDefineBitsJPEG4());
                case 91:
                    return (createTagDefineFont4());
                case 93:
                    return (createTagEnableTelemetry());
                case 94:
                    return (createTagPlaceObject4());
                case 253:
                    return (createTagSWFEncryptActions());
                case 0xFF:
                    return (createTagSWFEncryptSignature());
                default:
                    return (createTagUnknown(_arg_1));
            };
        }

        protected function createTagEnd():ITag
        {
            return (new TagEnd());
        }

        protected function createTagShowFrame():ITag
        {
            return (new TagShowFrame());
        }

        protected function createTagDefineShape():ITag
        {
            return (new TagDefineShape());
        }

        protected function createTagPlaceObject():ITag
        {
            return (new TagPlaceObject());
        }

        protected function createTagRemoveObject():ITag
        {
            return (new TagRemoveObject());
        }

        protected function createTagDefineBits():ITag
        {
            return (new TagDefineBits());
        }

        protected function createTagDefineButton():ITag
        {
            return (new TagDefineButton());
        }

        protected function createTagJPEGTables():ITag
        {
            return (new TagJPEGTables());
        }

        protected function createTagSetBackgroundColor():ITag
        {
            return (new TagSetBackgroundColor());
        }

        protected function createTagDefineFont():ITag
        {
            return (new TagDefineFont());
        }

        protected function createTagDefineText():ITag
        {
            return (new TagDefineText());
        }

        protected function createTagDoAction():ITag
        {
            return (new TagDoAction());
        }

        protected function createTagDefineFontInfo():ITag
        {
            return (new TagDefineFontInfo());
        }

        protected function createTagDefineSound():ITag
        {
            return (new TagDefineSound());
        }

        protected function createTagStartSound():ITag
        {
            return (new TagStartSound());
        }

        protected function createTagDefineButtonSound():ITag
        {
            return (new TagDefineButtonSound());
        }

        protected function createTagSoundStreamHead():ITag
        {
            return (new TagSoundStreamHead());
        }

        protected function createTagSoundStreamBlock():ITag
        {
            return (new TagSoundStreamBlock());
        }

        protected function createTagDefineBitsLossless():ITag
        {
            return (new TagDefineBitsLossless());
        }

        protected function createTagDefineBitsJPEG2():ITag
        {
            return (new TagDefineBitsJPEG2());
        }

        protected function createTagDefineShape2():ITag
        {
            return (new TagDefineShape2());
        }

        protected function createTagDefineButtonCxform():ITag
        {
            return (new TagDefineButtonCxform());
        }

        protected function createTagProtect():ITag
        {
            return (new TagProtect());
        }

        protected function createTagPlaceObject2():ITag
        {
            return (new TagPlaceObject2());
        }

        protected function createTagRemoveObject2():ITag
        {
            return (new TagRemoveObject2());
        }

        protected function createTagDefineShape3():ITag
        {
            return (new TagDefineShape3());
        }

        protected function createTagDefineText2():ITag
        {
            return (new TagDefineText2());
        }

        protected function createTagDefineButton2():ITag
        {
            return (new TagDefineButton2());
        }

        protected function createTagDefineBitsJPEG3():ITag
        {
            return (new TagDefineBitsJPEG3());
        }

        protected function createTagDefineBitsLossless2():ITag
        {
            return (new TagDefineBitsLossless2());
        }

        protected function createTagDefineEditText():ITag
        {
            return (new TagDefineEditText());
        }

        protected function createTagDefineSprite():ITag
        {
            return (new TagDefineSprite());
        }

        protected function createTagNameCharacter():ITag
        {
            return (new TagNameCharacter());
        }

        protected function createTagProductInfo():ITag
        {
            return (new TagProductInfo());
        }

        protected function createTagFrameLabel():ITag
        {
            return (new TagFrameLabel());
        }

        protected function createTagSoundStreamHead2():ITag
        {
            return (new TagSoundStreamHead2());
        }

        protected function createTagDefineMorphShape():ITag
        {
            return (new TagDefineMorphShape());
        }

        protected function createTagDefineFont2():ITag
        {
            return (new TagDefineFont2());
        }

        protected function createTagExportAssets():ITag
        {
            return (new TagExportAssets());
        }

        protected function createTagImportAssets():ITag
        {
            return (new TagImportAssets());
        }

        protected function createTagEnableDebugger():ITag
        {
            return (new TagEnableDebugger());
        }

        protected function createTagDoInitAction():ITag
        {
            return (new TagDoInitAction());
        }

        protected function createTagDefineVideoStream():ITag
        {
            return (new TagDefineVideoStream());
        }

        protected function createTagVideoFrame():ITag
        {
            return (new TagVideoFrame());
        }

        protected function createTagDefineFontInfo2():ITag
        {
            return (new TagDefineFontInfo2());
        }

        protected function createTagDebugID():ITag
        {
            return (new TagDebugID());
        }

        protected function createTagEnableDebugger2():ITag
        {
            return (new TagEnableDebugger2());
        }

        protected function createTagScriptLimits():ITag
        {
            return (new TagScriptLimits());
        }

        protected function createTagSetTabIndex():ITag
        {
            return (new TagSetTabIndex());
        }

        protected function createTagFileAttributes():ITag
        {
            return (new TagFileAttributes());
        }

        protected function createTagPlaceObject3():ITag
        {
            return (new TagPlaceObject3());
        }

        protected function createTagImportAssets2():ITag
        {
            return (new TagImportAssets2());
        }

        protected function createTagDefineFontAlignZones():ITag
        {
            return (new TagDefineFontAlignZones());
        }

        protected function createTagCSMTextSettings():ITag
        {
            return (new TagCSMTextSettings());
        }

        protected function createTagDefineFont3():ITag
        {
            return (new TagDefineFont3());
        }

        protected function createTagSymbolClass():ITag
        {
            return (new TagSymbolClass());
        }

        protected function createTagMetadata():ITag
        {
            return (new TagMetadata());
        }

        protected function createTagDefineScalingGrid():ITag
        {
            return (new TagDefineScalingGrid());
        }

        protected function createTagDoABC():ITag
        {
            return (new TagDoABC());
        }

        protected function createTagDoABCDeprecated():ITag
        {
            return (new TagDoABCDeprecated());
        }

        protected function createTagDefineShape4():ITag
        {
            return (new TagDefineShape4());
        }

        protected function createTagDefineMorphShape2():ITag
        {
            return (new TagDefineMorphShape2());
        }

        protected function createTagDefineSceneAndFrameLabelData():ITag
        {
            return (new TagDefineSceneAndFrameLabelData());
        }

        protected function createTagDefineBinaryData():ITag
        {
            return (new TagDefineBinaryData());
        }

        protected function createTagDefineFontName():ITag
        {
            return (new TagDefineFontName());
        }

        protected function createTagStartSound2():ITag
        {
            return (new TagStartSound2());
        }

        protected function createTagDefineBitsJPEG4():ITag
        {
            return (new TagDefineBitsJPEG4());
        }

        protected function createTagDefineFont4():ITag
        {
            return (new TagDefineFont4());
        }

        protected function createTagEnableTelemetry():ITag
        {
            return (new TagEnableTelemetry());
        }

        protected function createTagPlaceObject4():ITag
        {
            return (new TagPlaceObject4());
        }

        protected function createTagSWFEncryptActions():ITag
        {
            return (new TagSWFEncryptActions());
        }

        protected function createTagSWFEncryptSignature():ITag
        {
            return (new TagSWFEncryptSignature());
        }

        protected function createTagUnknown(_arg_1:uint):ITag
        {
            return (new TagUnknown(_arg_1));
        }


    }
}

