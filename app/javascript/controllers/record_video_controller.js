import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="record-video"
export default class extends Controller {
  static targets = ["start", "stop", "live", "form", "collapse", "video"]
  connect() {
    console.log(this.startTarget, this.stopTarget, this.liveTarget, this.collapseTarget)
  }
  record() {
    navigator.mediaDevices.getUserMedia({
      video: true,
      audio: true
    })
    .then(stream => {
      this.liveTarget.srcObject = stream;
      this.liveTarget.captureStream = this.liveTarget.captureStream || this.liveTarget.mozCaptureStream;
      return new Promise(resolve => this.liveTarget.onplaying = resolve);
    })
    .then(() => this.startRecording(this.liveTarget.captureStream()))
    .then (recordedChunks => {
      const recordedBlob = new Blob(recordedChunks, { type: "video/mp4" });
      console.log(recordedBlob);
      this.uploadToCloudinary(recordedBlob);
    })
  }

  startRecording(stream) {
    const recorder = new MediaRecorder(stream);
    let data = [];
    recorder.ondataavailable = event => data.push(event.data);
    recorder.start();
    const stopped = new Promise((resolve, reject) => {
        recorder.onstop = resolve;
        recorder.onerror = event => reject(event.name);
      });
    const recorded = this.stopRecording().then(
        () => {
          this.stopVideo();
          recorder.state == "recording" && recorder.stop();
        }
    );
  return Promise.all([
    stopped,
    recorded
  ]).then(() => data);
  }

  stopRecording() {
    return new Promise(resolve => this.stopTarget.addEventListener("click", resolve));
  }

  stopVideo() {
    this.liveTarget.srcObject.getTracks().forEach(track => track.stop());
  }

  replace(data) {
    this.videoTarget.innerHTML = data;
    this.videoTarget.classList.remove("d-none")
    this.collapseTarget.classList.add("d-none")
  }

  uploadToCloudinary(video) {
    const formData = new FormData(this.formTarget);
    formData.append('exercise_set[video]', video, `my_video${Math.floor(Math.random() * 10)}.mp4`);
    fetch(this.formTarget.action, {
      // headers: { "Accept": "application/json"},
      body: formData,
      method: "POST",
      headers: { 'Accept': 'text/plain' }
    })
      .then((response) => response.text())
      .then((data) => {
        console.log(data);
        this.replace(data);
      })
  }
}
