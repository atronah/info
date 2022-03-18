# ffmpeg


## Convert from .MOV to .MP4

```
ffmpeg -vcodec h264 -acodec mp2 -i source.mov target.mp4
```


```
for /f %f in ('dir /b .') do ffmpeg.exe -vcodec h264 -c:a aac -flags +global_header -i "%f" "%~nf.mp4" >> log.log 2>&1
```


## decode AAC

### Solution from Lars Windolf

(didn't work for me when decode .mov from iPad)

[Solution:](https://lzone.de/blog/Why-decoding-AAC-with-ffmpeg-doesn't-work)
Upgrade to latest ffmpeg and faad library version and add " -acodec libfaad " in front of the "-i" switch. This uses the libfaad AAC decoder, which is said to be a bit slower than the ffmpeg-builtin, but which decodes the AAC without complaining. For example:

```
ffmpeg -acodec libfaad -i input.mov -b 300kbit/s -ar 22050 -o test.flv
```


### default aac decoder

```
ffmpeg -vcodec h264 -c:a aac -i source.mov target.mp4
```



## other options


- `-flags +global_header` - [source](https://stackoverflow.com/questions/35866447/ffmpeg-invalid-data-found-when-processing-input-h264-to-h265)
