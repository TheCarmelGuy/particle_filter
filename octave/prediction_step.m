function particles = prediction_step(particles, u, noise)
% Updates the particles by drawing from the motion model
% Use u.r1, u.t, and u.r2 to access the rotation and translation values
% which have to be pertubated with Gaussian noise.
% The position of the i-th particle is given by the 3D vector
% particles(i).pose which represents (x, y, theta).

% noise parameters
% Assume Gaussian noise in each of the three parameters of the motion model.
% These three parameters may be used as standard deviations for sampling.
r1Noise = noise(1);
transNoise = noise(2);
r2Noise = noise(3);

numParticles = length(particles);

for i = 1:numParticles

  % append the old position to the history of the particle
  particles(i).history{end+1} = particles(i).pose;

  % TODO: sample a new pose for the particle
  sample_r1 = u.r1 - normrnd(0, r1Noise^2 + r2Noise^2);
  sample_trans = u.t - normrnd(0, transNoise^2 + r1Noise^2 + r2Noise^2); 
  sample_r2 = u.r2 - normrnd(0, r2Noise^2 + transNoise^2);

  x = particles(i).pose(1) + sample_trans*cos(particles(i).pose(3) + sample_r1);
  y = particles(i).pose(2) + sample_trans*sin(particles(i).pose(3) + sample_r1);
  theta = particles(i).pose(3) +  sample_r1 + sample_r2;
  
  particles(i).pose = [x y theta]; 


end

end
