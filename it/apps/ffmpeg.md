# ffmpeg


## Convert from .MOV to .MP4

```
ffmpeg -vcodec h264 -acodec mp2 -i source.mov target.mp4
```


```
for /f %f in ('dir /b .') do ffmpeg.exe -vcodec h264 -acodec mp2 -i "%f" "%~nf.mp4"
```